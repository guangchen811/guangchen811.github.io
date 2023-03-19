---
title: "Prompt_comparation"
date: 2023-03-17T15:03:57+08:00
draft: true
---

Large language models (LLMs) have become increasingly popular and accessible to people without technical expertise. This has brought about a significant change not only in the AI industry but also in other fields of work. It is therefore essential to conduct a comprehensive comparison of different types of LLMs.

In this blog, I will compare the following LLMs: ChatGPT, GPT4, New Bing, and Notion AI. Besides, Baidu have release their large multi-modal model, Wenxin Yiyan. I'll add the comparision with Wenxin Yiyan after get the access to it. I hope this blog can help you select the right LLM to assist your work and life. 

## Brief Introduction to Each LLM
### ChatGPT & GPT4

[ChatGPT](https://openai.com/blog/chatgpt): A model that is trained to follow an instruction in a prompt and provide a detailed response. It is a sibling model to [InstructGPT](https://openai.com/blog/instruction-following/).
[GPT4](https://openai.com/research/gpt-4): A large multimodal model that accepts image and text inputs, and emits text outputs. It exhibits human-level performance on various professional and academic benchmarks, although it is less capable than humans in many real-world scenarios.
<div align="center">
    <img src="/images/LLM/gpt_workflow.png" alt="Image 1" height=300>
    <figcaption align="center">Subcaption 1</figcaption>
    </div>

### New Bing
[New Bing](https://www.bing.com/new): A search engine enhanced by [GPT4](https://blogs.bing.com/search/march_2023/Confirmed-the-new-Bing-runs-on-OpenAI%E2%80%99s-GPT-4). Bing searches for relevant content across the web and then summarizes what it finds to generate a helpful response. It also cites its sources, so you're able to see links to the web content it references.
<div align="center">
    <img src="/images/LLM/Bing_workflow.png" alt="Image 1" height=300>
    <figcaption align="center">Subcaption 1</figcaption>
</div>

### Notion AI
[Notion AI](https://www.notion.so/product/ai): A connected assistant that helps you think bigger, work faster, and augments your creativity, right inside the functional workspace you’re already familiar with. Compared with other LLMs, Notion AI is integrated in notion pages, which are more focused on content-related questions. Thus, if your day-to-day involves reading docs, writing content, or taking notes, Notion AI can make you more efficient.
<div align="center">
    <img src="/images/LLM/notionAI_workflow.png" alt="Image 1" height=300>
    <figcaption align="center">Subcaption 1</figcaption>
</div>

## Which Prompts and Why These Prompts

To compare the performance of these LLMs, I will use a set of prompts that encompass a variety of use cases. The selected prompts will test each model's ability to handle different types of tasks, including factual information, creative writing, problem-solving, and more.

- General knowledge question: "What is photosynthesis?"
- Creative writing: "Write a short story about a talking tree."
- Problem-solving: "How can I reduce my electricity bill?"
- Technical explanation: "Explain the concept of blockchain technology."
- Opinions and recommendations: "What are the best strategies for effective time management?"
- Debug: "Please help me find the bug in this code."
- Text adjustment: "Add a number at the beginning of each paragraph in the following content. Replace all "。" with "." and bold all sentences with more than ten words."
- These prompts were chosen because they represent a diverse range of tasks and require different levels of understanding, creativity, and problem-solving skills. By using these prompts, we can gain insights into each LLM's strengths and weaknesses.

## LLM Comparison Results

### Prompt 1: What is photosynthesis?
<details><summary>ChatGPT (Default)</summary>

<small>

> Photosynthesis is the process by which green plants, algae, and some bacteria convert light energy from the sun into chemical energy in the form of organic compounds. During photosynthesis, carbon dioxide and water are combined to produce glucose (a type of sugar) and oxygen gas. This process takes place in specialized organelles called chloroplasts, which contain a green pigment called chlorophyll that absorbs light energy.
> 
>Photosynthesis can be summarized by the following equation:
>
>6 CO2 + 6 H2O + light energy → C6H12O6 + 6 O2
>
>In this equation, carbon dioxide (CO2) and water (H2O) are the reactants, while glucose (C6H12O6) and oxygen gas (O2) are the products. Photosynthesis is essential to life on Earth, as it provides the energy that fuels the majority of ecosystems and supports the growth and survival of plants and other photosynthetic organisms.

</small>

</details>

<details><summary>ChatGPT (Legacy)</summary>

<small>

> Photosynthesis is the process by which green plants, algae, and some bacteria convert light energy into chemical energy in the form of organic compounds, such as glucose. This process takes place in the chloroplasts of the plant cells, and it is the main source of energy for almost all living organisms on Earth. During photosynthesis, carbon dioxide and water are taken in and converted into glucose and oxygen, with the latter being released into the atmosphere as a waste product. The glucose produced is used by the plant as a source of energy and building material, while the oxygen is used by other organisms for respiration. In summary, photosynthesis is a crucial process that provides the energy needed for life on Earth, and it also helps regulate the levels of atmospheric oxygen and carbon dioxide.

</small>

</details>

<details><summary>GPT-4</summary>

<small>

> Photosynthesis is a vital biological process that occurs in plants, algae, and some bacteria, enabling them to convert sunlight into chemical energy. This process is essential for life on Earth, as it is the primary means by which oxygen is produced and carbon dioxide is removed from the atmosphere.
>
> During photosynthesis, organisms absorb sunlight through pigments such as chlorophyll, which is predominantly found in the chloroplasts of plant cells. The energy from sunlight is then used to convert carbon dioxide (CO2) and water (H2O) into glucose (C6H12O6), a simple sugar that serves as an energy source for the organism. Oxygen (O2) is produced as a byproduct and released into the atmosphere.
>
> The overall equation for photosynthesis can be represented as:
>
> 6CO2 + 6H2O + sunlight → C6H12O6 + 6O2
>
> Photosynthesis consists of two main stages: the light-dependent reactions and the light-independent reactions (also known as the Calvin cycle). The light-dependent reactions occur in the thylakoid membranes of the chloroplasts and generate ATP (adenosine triphosphate) and NADPH (nicotinamide adenine dinucleotide phosphate), which are energy-rich molecules. The light-independent reactions, on the other hand, occur in the stroma of the chloroplasts and use the energy from ATP and NADPH to fix carbon dioxide into glucose and other organic molecules.
>
> Photosynthesis is crucial for maintaining the balance of oxygen and carbon dioxide in the atmosphere and serves as the basis of the food chain, as plants are primary producers that support the energy needs of other organisms.

</small>

</details>

<details><summary>New Bing</summary>

<small>

> Photosynthesis is a process by which plants and some other organisms use sunlight to make their own food from carbon dioxide and water [[1]](https://bing.com/search?q=photosynthesis) [[2]](https://www.nationalgeographic.org/encyclopedia/photosynthesis/). It also produces oxygen as a by-product [[2]](https://www.nationalgeographic.org/encyclopedia/photosynthesis/) [[3]](https://www.britannica.com/science/photosynthesis). Photosynthesis is essential for life on Earth because it provides oxygen and organic compounds that can be used as energy sources2.
> 
> For more information: [1. bing.com](https://bing.com/search?q=photosynthesis) [2. nationalgeographic.org](https://www.nationalgeographic.org/encyclopedia/photosynthesis/) [3. britannica.com](https://www.britannica.com/science/photosynthesis)  [4.en.wikipedia.org](https://en.wikipedia.org/wiki/Photosynthesis)

</small>

</details>

<details><summary>Notion AI</summary>

<small>

> Photosynthesis is the process by which green plants and some other organisms use sunlight to synthesize foods with the help of chlorophyll.

</small>

</details>

### Prompt 2: Please provide me with the easiest method to set up a visually appealing terminal on a Mac. The steps should be detailed and feasible.

<details><summary>ChatGPT (Default)</summary>
<small>

> Certainly! Here are the detailed steps to set up a visually appealing terminal on a Mac:
>
> 1. Install a terminal emulator: The default terminal emulator on Mac is Terminal, but you can also install third-party terminal emulators such as iTerm2 or Hyper.
> 2. Install a color scheme: You can use a color scheme to customize the appearance of your terminal. There are many free color schemes available online, such as Solarized, Dracula, or One Dark. To install a color scheme, you can follow these steps:
>    - Download the color scheme file (usually a .terminal or .itermcolors file).
>    - Open the Terminal preferences by pressing Command + ,.
>    - Go to the "Profiles" tab and click on the "Import" button.
>    - Select the downloaded color scheme file and click "Open".
>The new color scheme will be added to your list of profiles.
>3. Install a custom font: You can use a custom font to change the appearance of the text in your terminal. Some popular fonts for programming include Fira Code, Source Code Pro, or JetBrains Mono. To install a font, you can follow these steps:
>   - Download the font file (usually a .ttf or .otf file).
>   - Double-click on the downloaded file to open the Font Book application.
>   - Click on the "Install Font" button to install the font.
>4. Configure the terminal settings: You can customize the terminal settings to change the font size, enable transparency, or add custom command prompts. To access the terminal settings, follow these steps:
>    - Open the Terminal preferences by pressing Command + ,.
>    - Go to the "Profiles" tab and select the profile you want to customize.
>    - Click on the "Advanced" tab to access more settings, such as text encoding or ANSI colors.
>    - Modify the settings to your liking and click "OK" to save the changes.
> By following these steps, you should be able to set up a visually appealing terminal on your Mac.

</small>
</details>

<details><summary>ChatGPT (Legacy)</summary>
<small>

> Setting up a visually appealing terminal on a Mac can be done using a few steps. Here's a detailed guide on how to do it:
> 
> 1. Install iTerm2: iTerm2 is a popular terminal emulator for Mac. It offers features like split-pane viewing, hotkey window, and search that make it a great choice for a visually appealing terminal. You can download and install iTerm2 from https://www.iterm2.com/.
> 
> 2. Install a color scheme: iTerm2 supports a wide range of color schemes that you can choose from to customize your terminal. Some popular color schemes include Solarized, Monokai, and Tomorrow Night. You can find a list of color schemes at https://github.com/mbadolato/iTerm2-Color-Schemes. To install a color scheme, simply download the .itermcolors file and import it into iTerm2 using the "Preferences" > "Profiles" > "Colors" > "Color Presets" > "Import" option.
> 
> 3. Install a font: iTerm2 also supports a wide range of fonts. Some popular choices for terminal fonts include Inconsolata, Hack, and Monaco. You can download and install a font of your choice. Once you have the font installed, you can set it as the default font for iTerm2 by going to "Preferences" > "Profiles" > "Text" > "Change Font".
> 
> 4. Set up a profile: iTerm2 allows you to create multiple profiles, each with its own set of preferences, color schemes, and fonts. To create a profile, go to "Preferences" > "Profiles" > " + " to create a new profile. You can then set the default color scheme and font for this profile.
> 
> 5. Customize your terminal: Finally, you can further customize your terminal by adjusting its appearance and behavior. For example, you can change the background color, transparency, and blur. You can also change the cursor style and appearance, and set up hotkeys for frequently used commands.

> By following these steps, you can set up a visually appealing terminal on your Mac that is both functional and aesthetically pleasing.

</small>
</details>

<details><summary>GPT-4</summary>
<small>

> To set up a visually appealing terminal on a Mac, you can use the built-in Terminal app and customize it or install a third-party terminal emulator like iTerm2. Here, we'll guide you through customizing the built-in Terminal app for simplicity.
> 1. Open Terminal:
>
>    Navigate to your Applications folder, then open the Utilities folder and double-click on Terminal.
>
> 2. Access Terminal Preferences:
>
>    In the top-left corner of the screen, click on the "Terminal" menu and then choose "Preferences" from the drop-down menu.
>
> 3. Choose a pre-built theme:
>
>    In the Preferences window, you'll see the "Profiles" tab. Here, you can choose from several pre-built themes. Select a theme that appeals to you by clicking on it.
>
> 4. Customize the selected theme:
>
>    Once you have chosen a theme, you can further customize its appearance. Here are some options you can modify:
>
>    - Text: Click the "Text" tab to change the font, size, and color of the text in the terminal. Choose a font and size that are easy to read and a color that contrasts well with the background.
>    
>    - Background: In the "Window" tab, you can adjust the background color or set a custom image as the background. Choose a color or image that complements the text color for better visibility.
>    
>    - Cursor: Navigate to the "Cursor" tab to change the shape and color of the cursor. Opt for a shape and color that are easily noticeable against the background.
>    
>    - Window settings: Under the "Window" tab, you can set the terminal window size, position, and transparency. Adjust these settings according to your preference.
>
> 5. Set the customized theme as default:
>
>    In the "Profiles" tab, click on the gear icon at the bottom of the theme list and select "Set as Default" to make the customized theme your default terminal profile.
>
> 6. Save your changes:
>
>    Close the Preferences window, and the changes you made will be automatically saved.

</small>
</details>

<details><summary>New Bing</summary>

<small>

> One possible method to set up a visually appealing terminal on a Mac is:
> 
> - Open the Terminal app from the Applications/Utilities folder or use Spotlight to search for it.
> - In the Terminal menu bar, click on Terminal > Preferences.
> - In the Preferences window, select the Profiles tab. This section will let you adjust the appearance of the Terminal window [[1]](https://www.maketecheasier.com/customize-mac-terminal/).
> - You can choose from a list of preset profiles on the left sidebar or create your own by clicking on the + button at the bottom [[2]](https://www.makeuseof.com/tag/customize-mac-terminal/) [[1]](https://www.maketecheasier.com/customize-mac-terminal/).
> - You can change various settings such as background and text color, font type and size, cursor type and color, window size and position, etc. by clicking on different tabs such as Text, Window, Shell, etc. [[2]](https://www.makeuseof.com/tag/customize-mac-terminal/) [[1]](https://www.maketecheasier.com/customize-mac-terminal/).
> - To apply your changes, click on Default at the bottom of the sidebar. This will make your selected profile the default one for new Terminal windows [[2]](https://www.makeuseof.com/tag/customize-mac-terminal/) [[1]](https://www.maketecheasier.com/customize-mac-terminal/).
> - You can also customize some aspects of how Terminal behaves by selecting the General tab in Preferences. For example, you can choose what to show on the title bar of Terminal windows, how to handle closing windows or tabs, how many lines of scrollback to keep in memory, etc. [[2]](https://www.makeuseof.com/tag/customize-mac-terminal/) [[1]](https://www.maketecheasier.com/customize-mac-terminal/).
>
> For more details: [maketecheasier.com](https://www.maketecheasier.com/customize-mac-terminal/) [makeuseof.com](https://www.makeuseof.com/tag/customize-mac-terminal/) [appleinsider.com](https://appleinsider.com/articles/19/01/31/how-to-use-the-terminal-to-change-the-look-of-your-mac-and-speed-up-your-work)
</small>

</details>

<details><summary>Notion AI</summary>

<small>

> If you spend a lot of time working on the terminal, it's important to make it visually appealing and comfortable to use. Here are the steps to set up a visually appealing terminal on your Mac:
> 
> 1. Install iTerm2: iTerm2 is a more powerful terminal emulator compared to the default Terminal app on Mac. Download and install iTerm2 from [https://iterm2.com/](https://iterm2.com/).
> 2. Install Oh My Zsh: Oh My Zsh is a popular framework for managing Zsh configurations. You can install it by running the following command on your terminal:
> 
> ```
> sh -c "$(curl -fsSL <https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh>)"
> 
> ```
> 
> 1. Choose a theme: Oh My Zsh comes with several themes that you can choose from. You can view the list of available themes by running the following command:
> 
> ```
> ls ~/.oh-my-zsh/themes/
> 
> ```
> 
> To set a theme, open the `.zshrc` file in your home directory using a text editor and change the `ZSH_THEME` variable to the name of the theme you want to use. For example:
> 
> ```
> ZSH_THEME="agnoster"
> 
> ```
> 
> Save the file and reload your terminal for the changes to take effect.
> 
> 1. Install Powerline fonts: Powerline fonts are a set of fonts that contain special characters used by some terminal themes. You can download and install them from [https://github.com/powerline/fonts](https://github.com/powerline/fonts). Once installed, set the font of your terminal to a Powerline font.
> 2. Customize the prompt: You can customize the prompt to display useful information such as the current directory, Git branch, and more. To do this, open the `.zshrc` file in your home directory and modify the `PROMPT` variable. For example:
> 
> ```
> PROMPT='%n@%m:%~$(git_prompt_info) $ '
>
> ```
> 
> Save the file and reload your terminal for the changes to take effect.
> 
> With these steps, you should now have a visually appealing and comfortable to use terminal on your Mac.

</small>

</details>

### Prompt 3: Write a short story about a talking tree.
<details><summary>ChatGPT (Default)</summary>

<small>

> 

</small>

</details>

<details><summary>ChatGPT (Legacy)</summary>

<small>

</small>

</details>

<details><summary>GPT-4</summary>

<small>

> 

</small>

</details>

<details><summary>New Bing</summary>

<small>

> 

</small>

</details>

<details><summary>Notion AI</summary>

<small>

> 

</small>

</details>

## Conclusion


Overall, ChatGPT and GPT4 performed exceptionally well across all tasks, showcasing their versatility and effectiveness in various use cases. New Bing is a reliable choice for information retrieval and summarization, but it may not be the best option for creative or opinion-based tasks. Notion AI, while offering valuable assistance within its platform, may not be the most suitable choice for more in-depth or technical inquiries.

Ultimately, the choice of LLM will depend on your specific needs and preferences. If you're looking for an all-rounder with strong performance in diverse tasks, ChatGPT and GPT4 are excellent choices. For focused research and summarization, New Bing is a reliable option. If you're already a Notion user and need assistance within the platform, Notion AI can help improve your productivity.

Stay tuned for an update on the comparison with Wenxin Yiyan, Baidu's large multi-modal model, once access is granted.

