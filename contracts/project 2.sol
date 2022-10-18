pragma solidity ^ 0.8.17;

contract TodoList {

    struct Todo {
        string text;
        bool completed;
    }

    Todo[] todos;

    function create(string calldata _text) public {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    }

    function get(uint _index) public view returns (string memory, bool) {
        Todo storage todo = todos[_index];
        return(todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) public {
        todos[_index].completed = !todos[_index].completed;
    }

    
}