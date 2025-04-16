#!/bin/bash

# 获取标准格式的提交时间
RAW_DATE=$(git log -1 --format=%ci)
echo "原始提交时间: $RAW_DATE"

# 手动提取并格式化时间
YEAR=$(echo $RAW_DATE | cut -d' ' -f1 | cut -d'-' -f1)
MONTH=$(echo $RAW_DATE | cut -d' ' -f1 | cut -d'-' -f2)
DAY=$(echo $RAW_DATE | cut -d' ' -f1 | cut -d'-' -f3)
TIME=$(echo $RAW_DATE | cut -d' ' -f2 | tr -d ':')

# 构建时间戳
COMMIT_TIMESTAMP="${YEAR}${MONTH}${DAY}${TIME}"
echo "提交UTC时间戳: $COMMIT_TIMESTAMP"

# 获取Git提交的哈希值
COMMIT_HASH=$(git rev-parse --short=12 HEAD)
echo "提交哈希值: $COMMIT_HASH"

# 获取基础版本日期部分(格式YYMMDD)
YEAR_SHORT=${YEAR:2:2}
BASE_DATE="${YEAR_SHORT}${MONTH}${DAY}"
echo "基础版本日期: $BASE_DATE"

# 组装成伪版本号
PSEUDO_VERSION="v1.${BASE_DATE}.1-0.${COMMIT_TIMESTAMP}-${COMMIT_HASH}"
echo "完整伪版本号: $PSEUDO_VERSION"

echo ""
echo "用于go.mod的replace指令:"
echo "replace github.com/原始仓库/模块 => github.com/你的仓库/模块 $PSEUDO_VERSION"
