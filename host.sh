#!/bin/bash

# 定义要添加的条目
ENTRIES=(
"127.0.0.1 erp.acunetix.com"
"::1 erp.acunetix.com"
)

# 检查并添加每一个条目
for entry in "${ENTRIES[@]}"
do
    # 检查 /etc/hosts 是否已经包含这个条目
    if ! grep -q "$entry" /etc/hosts; then
        # 如果不存在，则添加到 /etc/hosts
        echo "$entry" |  tee -a /etc/hosts > /dev/null
    fi
done

echo "Host entries have been updated."
