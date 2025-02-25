# Notes

## 1. Compiling Elixir & Running Scripts
> Refer to functionalsis.ex

To run the code, run:
- ```mix compile```
- ```iex -S mix``` (creates a new interactive session)
- ```Functionalsis.hello``` (input name of the module + name of the function you want to invoke)
- The last line should output ```:world``` in the terminal

Or run:
- ```mix run -e "Functionalsis.hello"```. However, this will not return any value in our case, unless the return value is changed into an output (so in ```def hello```, ```:world``` would have to be changed to ```IO.puts(":world")``` otherwise it won't be displayed in the terminal). Therefore either use the Elixir sessionizer, or use outputs as return values when running a file directly.

Currently, the way the project is set up would require a user to compile it then invoke a specific funciton in the code. Another way to run Elixir code is the following:
- The Elixir code: ```Module.Function()``` (in our example: ```Functionalsis.hello()```)
- In the console: ```mix run```
> [!NOTE]
> Note that this code is only executed during *compile time*, so it will be ignored the second time it is invoked (unless it is recompiled).

To combat this:
1. Add a mod in ```mix.exs```
```
def application do
    [
      mod: {Functionalsis, []},
      extra_applications: [:logger]
    ]
  end
```

```mod``` is used to specify the module that access the entry point for the application. It expects the Module name plus any argument that should be passed to a starter function. Since we're not passing any data to the function, the brackets are empty.

2. Run the following code:
```
defmodule Functionalsis do
    use Application
    
    def start(_type, _args) do
        # code
        IO.puts(Functionalsis.hello())
        Supervisor.start_link([], strategy: :one_for_one)    
    end


    def hello do
        :world
    end
end
```
A Supervisor is a process that supervises other processes. It restarts children processes (which we name inside the [ ]). Strategy one_for_one signifies that if a child process crashes, then only that process will be restarted.
