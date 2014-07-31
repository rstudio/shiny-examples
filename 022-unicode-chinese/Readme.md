这个例子展示了Shiny应用中的中文字符。多字节字符在Windows上一直都是让人头疼的问题，因为Windows不像Linux或苹果系统那样统一使用UTF-8编码，而是有自己的成百上千种编码，不同的系统语言环境有不同的默认字符编码，每次涉及到多字节字符的读写问题的时候，开发者或用户都要问自己一个问题：我应该用什么编码？从shiny版本0.10.1开始，我们强制跟shiny应用有关的文件都使用UTF-8编码，包括ui.R / server.R / global.R / DESCRIPTION / README.md文件（不是所有文件都是shiny应用必需的）。如果你使用RStudio编辑器，你可以从菜单File -> Save with Encoding选择UTF-8编码保存你的shiny应用文件。

If you do not understand Chinese, please take a look at [this article](http://shiny.rstudio.com/articles/unicode.html).
