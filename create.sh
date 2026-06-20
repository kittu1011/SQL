#!/bin/bash
CACHE=".name_cache.json"
[ -f "$CACHE" ] || echo '{}' > "$CACHE"

problem_number=$1
if [ -z "$problem_number" ]; then
    echo "Usage: create [problem number]"
    exit 1
fi

# Pad number to 4 digits
padded=$(printf "%04d" $problem_number)

# Check cache first (keyed by problem number)
cached=$(jq -r --arg num "$problem_number" '.[$num]' "$CACHE")

if [ "$cached" != "null" ] && [ -n "$cached" ]; then
    title_slug=$(echo "$cached" | jq -r '.titleSlug')
    difficulty=$(echo "$cached" | jq -r '.difficulty')
else
    # Query by frontend ID using current schema (questionList aliased as problemsetQuestionList)
    response=$(curl -s -X POST https://leetcode.com/graphql \
        -H "Content-Type: application/json" \
        -H "Cookie: LEETCODE_SESSION=$LEETCODE_SESSION" \
        -d "$(jq -n --arg num "$problem_number" '{
            query: "query problemsetQuestionList($categorySlug: String, $limit: Int, $skip: Int, $filters: QuestionListFilterInput) { problemsetQuestionList: questionList(categorySlug: $categorySlug, limit: $limit, skip: $skip, filters: $filters) { questions: data { questionFrontendId titleSlug difficulty } } } ",
            variables: { categorySlug: "", skip: 0, limit: 1, filters: { searchKeywords: $num } }
        }')")

    title_slug=$(echo "$response" | jq -r '.data.problemsetQuestionList.questions[0].titleSlug')
    difficulty=$(echo "$response" | jq -r '.data.problemsetQuestionList.questions[0].difficulty')

    if [ "$title_slug" = "null" ] || [ -z "$title_slug" ]; then
        echo "Could not find problem $problem_number"
        exit 1
    fi

    # Write to cache as a nested object: { "42": { "titleSlug": "...", "difficulty": "..." } }
    jq --arg num "$problem_number" --arg slug "$title_slug" --arg diff "$difficulty" \
        '.[$num] = { "titleSlug": $slug, "difficulty": $diff }' "$CACHE" > temp.json && mv temp.json "$CACHE"
fi

echo "Problem: $title_slug ($difficulty)"
echo ""
echo "Available folders:"
ls -d */ | grep -v ".git"
echo ""
read -p "Folder: " folder

folder="${folder%/}"  # strip trailing slash if they added one

if [ ! -d "$folder" ]; then
    echo "Folder '$folder' does not exist"
    exit 1
fi

filename="${padded}_${title_slug//-/_}.sql"
filepath="$folder/$filename"

touch "$filepath"
echo "Created $filepath"