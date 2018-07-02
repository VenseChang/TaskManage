# Training

## Version
- Ruby: 2.4.1
- Rails: 2.5.0

## Table Schema  
### User
|column|type|memo|
|---|---|---|
|email|string||
|password|string||

### Profile    
|column|type|memo|
|---|---|---|
|first_name|string||
|last_name|string||
|nickname|string||
|avatar|string||
|role|string||
|user|integer||

### Task
|column|type|memo|
|---|---|---|
|end_time|datetime||
|priority|integer||
|title|string||
|content|text||
|status|string||
|task_tag_id|integer||
|user_id|integer||

### TaskMember
|column|type|memo|
|---|---|---|
|task_id|integer||
|user_id|integer||

### TaskTag
|column|type|memo|
|---|---|---|
|task_id|integer||
|tag_id|integer||

### Tag
|column|type|memo|
|---|---|---|
|description|string||
|enabled|boolean|default: true|