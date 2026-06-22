#set align(left)
#set par(justify: false, first-line-indent: 0pt)
#import "/utils/print_page_break.typ": print_page_break

= OSC Sequence Example <osc>

The shell integration layer relies on OSC sequences to track terminal state. This example shows how the shell emits OSC 133 markers at command start and prompt start. The terminal client interprets the prompt-start marker as the end of the preceding command execution and reconstructs structured command blocks from the resulting terminal output.

*Simplified OSC Sequence Trace*

This section shows a simplified and annotated representation of the emitted OSC sequences together with the rendered terminal output. The example is normalized for readability while preserving the marker structure used to reconstruct command boundaries.

```
]133;prompt_started
ai-terminal-demo git:(main) ✗ ls
]133;prompt_finished
]133;command_started;6c73
.rw-r--r--@  7 Mar 12:00  cert.txt
.rw-r--r--@ 16 Mar 20:06  dog.jpg
.rw-r--r--@ 25 Mar 00:54  gradle-config.txt
.rw-r--r--@ 25 Mar 00:53 󱁻 gradle.config
.rw-r--r--@ 17 Apr 22:31  Main.class
.rw-r--r--@ 16 Apr 16:01  Main.java
]133;prompt_started
➜  ai-terminal-demo git:(main) ✗ echo hello world
]133;command_started;6563686f2068656c6c6f20776f726c64
hello world
]133;prompt_started
➜  ai-terminal-demo git:(main) ✗
```

#print_page_break(print: true, to: "odd")

*Terminal History*

This section shows how the terminal client reconstructs structured command blocks from the raw OSC sequences. Each block contains the command text and its output.

```
[{
  command: 'ls',
  output: '.rw-r--r--@  7 Mar 12:00  cert.txt
.rw-r--r--@ 16 Mar 20:06  dog.jpg
.rw-r--r--@ 25 Mar 00:54  gradle-config.txt
.rw-r--r--@ 25 Mar 00:53 󱁻 gradle.config
.rw-r--r--@ 17 Apr 22:31  Main.class
.rw-r--r--@ 16 Apr 16:01  Main.java'
},
{
  command: 'echo hello world',
  output: 'hello world'
}]

```