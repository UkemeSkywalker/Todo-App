// SPDX-License-Identifier: GPT-3

pragma solidity ^0.8.4;

contract todo{

    struct todoItem {
        string itemTitle;
        bool checked;
        uint256 startTime;
        uint256 endTime;

    }

    uint256 id = 1;

    todoItem[] todoList;

    mapping(uint256 => todoItem ) todoID;

    event todoCreated(string indexed itemTitle_, string indexed message, uint indexed time );
    event todoMarkedAsDone(string indexed itemTitle_, string indexed message, uint indexed time );


    function createTodo(string memory _itemTitle) external{
        
        todoItem storage item = todoID[id];

        item.itemTitle = _itemTitle;
        uint256 timeNow = block.timestamp;
        item.startTime = timeNow;
        
        todoList.push(todoItem({ 
            itemTitle: _itemTitle,
            checked: false,
            startTime: timeNow,
            endTime: 0
             }));

          id++;

        emit todoCreated(_itemTitle, "Todo Created at:", timeNow);
    }


    function showAllTodo() external view returns(todoItem[] memory){
        return todoList;
    }

    function editTodo(string memory _itemTitle, uint index)external {
        todoItem storage item = todoList[index];
        item.itemTitle =_itemTitle;
    }

    function markAsDone(uint index) external{
        todoItem storage item = todoList[index];
        uint timeNow = block.timestamp;
        item.endTime = timeNow;

        emit todoMarkedAsDone(item.itemTitle, "Todo Marked as done at:", timeNow);
    }

    function deleteTodo(uint index) external {
        for(uint i = index; i < todoList.length - 1; i++){
            todoList[i] = todoList[i + 1];
        }
        todoList.pop();
    }


}