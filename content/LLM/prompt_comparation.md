---
title: "Choosing the Right LLM: A Comparison of ChatGPT, GPT-4, New Bing, and Notion AI for Different Scenarios"
date: 2023-03-17T15:03:57+08:00
draft: false
---

Large language models (LLMs) have become increasingly popular and accessible to people without technical expertise. This has brought about a significant change not only in the AI industry but also in other fields of work. However, faced with so many different LLMs, how do we choose different LLMs to maximize their help to our work and life? For example, when we want to polish an article, should we open a ChatGPT dialog box, or should we transfer it to Notion for processing by Notion AI?

In this blog, I will compare the following LLMs: ChatGPT, GPT-4, New Bing, and Notion AI. Besides, Baidu have release their large multi-modal model, Wenxin Yiyan. I'll add the comparision with Wenxin Yiyan after get the access to it. I hope this blog can help you select the right LLM to assist your work and life. If you are not interested in the specific experiments, please directly refer to the [takeaways](#takeaways).

## Brief Introduction to Each LLM
### ChatGPT & GPT-4

[ChatGPT](https://openai.com/blog/chatgpt): A model that is trained to follow an instruction in a prompt and provide a detailed response. It is a sibling model to [InstructGPT](https://openai.com/blog/instruction-following/). There are two versions of ChatGPT being tested here (Default and Legacy). Default is a version optimized by OpenAI for ChatGPT Plus users for faster response time. Legacy is the version that OpenAI made available to ChatGPT Plus users before the release of GPT-4. Default version has better consistency compared to Legacy version. 

[GPT-4](https://openai.com/research/gpt-4): A large multimodal model that accepts image and text inputs, and emits text outputs. It exhibits human-level performance on various professional and academic benchmarks, although it is less capable than humans in many real-world scenarios. Here, we only test its ability on language-related tasks.

The following flowchart illustrates their general working principle. They achieves multi-turn dialogue by taking historical information and new questions as inputs together.

<div align="center">
    <img src="/images/LLM/gpt_workflow.png" alt="Image 1" height=300>
    <figcaption align="center">Overall working principle of ChatGPT series models. </figcaption>
    </div>

### New Bing
[New Bing](https://www.bing.com/new): A search engine enhanced by [GPT-4](https://blogs.bing.com/search/march_2023/Confirmed-the-new-Bing-runs-on-OpenAI%E2%80%99s-GPT-4). Bing searches for relevant content across the web and then summarizes what it finds to generate a helpful response. It also cites its sources, so you're able to see links to the web content it references.

As shown in the flowchart below, New Bing summarizes user input into search keywords and uses a search engine to perform a search. Afterwards, it compiles the search responses and the user's question together as input to formulate its response.

<div align="center">
    <img src="/images/LLM/Bing_workflow.png" alt="Image 1" height=300>
    <figcaption align="center">Overall working principle of New Bing.</figcaption>
</div>

### Notion AI
[Notion AI](https://www.notion.so/product/ai): A connected assistant that helps you think bigger, work faster, and augments your creativity, right inside the functional workspace you’re already familiar with. Compared with other LLMs, Notion AI is integrated in notion pages, which are more focused on content-related questions. Thus, if your day-to-day involves reading docs, writing content, or taking notes, Notion AI can make you more efficient.

If there is text available on the corresponding page, Notion AI will use the selected text in Notion Pages (or all of the text if none is selected) as a part of the model input, in order to obtain a contextually relevant response.

<div align="center">
    <img src="/images/LLM/notionAI_workflow.png" alt="Image 1" height=300>
    <figcaption align="center">Overall working principle of Notion AI.</figcaption>
</div>

## Which Prompts and Why These Prompts

To compare the performance of these LLMs, I will use a set of prompts that encompass a variety of use cases. The selected prompts will test each model's ability to handle different types of tasks, including factual information, creative writing, problem-solving, and more.

- General knowledge question: "What is photosynthesis?"
- Resolving technical issues: "Please provide me with the easiest method to set up a visually appealing terminal on a Mac. The steps should be detailed and feasible."
- Text adjustment: "Add a number at the beginning of each paragraph in the following content. Replace all `"` with `'`. If a sentence starts with 'a', please replace it with an uppercase letter. Otherwise, keep it unchanged. Bold all sentences with more than ten words."
- Literature collection and organization: "Providing important literature in the development process of generative diffusion model."
- time-awareness and connectivity: "What is today's date and day of the week? How is the weather?"
These prompts were chosen because they represent a diverse range of tasks and require different levels of understanding, creativity, and problem-solving skills. By using these prompts, we can gain insights into each LLM's strengths and weaknesses.

> Note: The applications of LLMs are very extensive, and here I only test some representative and general applications. <span style="color: blue;">It is hoped that these tests will inspire practitioners from various industries in choosing appropriate models for their specific needs.</span> 

## LLM Comparison Results

### General knowledge question
<small>

> Prompt: What is photosynthesis?

</small>
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

#### Performance

<small>

The responses from ChatGPT (Default) and GPT-4 provide comprehensive explanations of photosynthesis, including the reactants and products, the role of chlorophyll, the two main stages of photosynthesis, and its significance for life on Earth. ChatGPT (Legacy) provides a simpler explanation of the process and its importance. On the other hand, New Bing's response is brief and summarizes the basic information about photosynthesis. Notion AI's response is the least informative, providing only a general description of the process. Overall, ChatGPT (Default) and GPT-4 provide the most detailed and informative explanations of photosynthesis.

</small>

### Resolving technical issues
<small>

> Please provide me with the easiest method to set up a visually appealing terminal on a Mac. The steps should be detailed and feasible.

</small>

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
> 
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

#### Performance

<small>

> Apart from New Bing, all other models provided specific steps for execution. I am confident that with further conversation, each model can provide concrete and actionable steps. New Bing, however, appears to be more inclined towards providing relevant reference documents. Of course, this does not mean that New Bing lacks the relevant capabilities since it is based on GPT-4. However, as a search tool, this may not be its most suitable way of functioning.

</small>

### Text adjustment
<small>

> Add a number at the beginning of each paragraph in the following content. Replace all `"` with `'`. If a sentence starts with 'a', please replace it with an lowercase letter. Otherwise, keep it unchanged. Bold all sentences with more than ten words.
> Here is the content: 
> 
> ```
> Amidst the whirlwind of technological advancements, ChatGPT has revolutionized the way people communicate and access information. "Always available, always accurate," the AI-powered tool offers unparalleled assistance, transcending language barriers and cultural differences.
> 
> As a result, users can quickly and efficiently find answers to questions and solve problems that once seemed insurmountable.
> 
> ```
> Now, please show me the modified content.

</small>

<details><summary>ChatGPT (Default)</summary>

<small>

> 1. Amidst the whirlwind of technological advancements, ChatGPT has revolutionized the way people communicate and access information. 'Always available, always accurate,' the AI-powered tool offers unparalleled assistance, transcending language barriers and cultural differences.
>
> 2. As a result, users can quickly and efficiently find answers to questions and solve problems that once seemed insurmountable.

</small>

</details>

<details><summary>ChatGPT (Legacy)</summary>

<small>

> 1. Amidst the whirlwind of technological advancements, **ChatGPT has revolutionized the way people communicate and access information.** "Always available, always accurate," the AI-powered tool offers unparalleled assistance, transcending language barriers and cultural differences.
> 
> 2. **As a result, users can quickly and efficiently find answers to questions and solve problems that once seemed insurmountable.**

</small>

</details>

<details><summary>GPT-4</summary>

<small>

> 1. **Amidst the whirlwind of technological advancements, ChatGPT has revolutionized the way people communicate and access information.** 'Always available, always accurate,' the AI-powered tool offers unparalleled assistance, transcending language barriers and cultural differences.
> 
> 2. **As a result, users can quickly and efficiently find answers to questions and solve problems that once seemed insurmountable.**

</small>

</details>

<details><summary>New Bing</summary>

<small>

> Here is the modified content:
> 
> 1. **Amidst the whirlwind of technological advancements, ChatGPT has revolutionized the way people communicate and access information.** 'Always available, always accurate,' the AI-powered tool offers unparalleled assistance, transcending language barriers and cultural differences.
>
> 2. As a result, users can quickly and efficiently find answers to questions and solve problems that once seemed insurmountable.

</small>

</details>

<details><summary>Notion AI</summary>

<small>

> 1. Amidst the whirlwind of technological advancements, ChatGPT has revolutionized the way people communicate and access information. **'Always available, always accurate,'** the AI-powered tool offers unparalleled assistance, transcending language barriers and cultural differences.
>
> 2. **As a result, users can quickly and efficiently find answers to questions and solve problems that once seemed insurmountable.**

</small>

</details>

#### Performance

<small>

Apart from GPT-4, none of the other models fully met the peculiar requirements I presented. However, LLMs have shown the potential to replace regular expressions in performing long text matching and replacement tasks.

</small>

### Literature collection and organization

<small>

> Providing important literature in the development process of generative diffusion model.

</small>

<details><summary>ChatGPT (Default)</summary>

<small>

> The Generative Diffusion Model (GDM) is a recent deep learning approach that has been shown to achieve state-of-the-art results in image generation, audio synthesis, and text generation. In the development of GDM, several important literature have contributed to its advancement. Below are some of the important literature that can be helpful in the development process of GDM:
> 
> "Improved Variational Inference with Inverse Autoregressive Flow" by Diederik P. Kingma et al. (2016): This paper introduces a technique called Inverse Autoregressive Flow (IAF) that can be used to improve the performance of variational autoencoders (VAEs), which are a key component of GDM. IAF provides a more flexible way of modeling the posterior distribution of the latent variables in VAEs, which can improve their performance in complex generative tasks.
>
> "Density Estimation Using Real NVP" by Laurent Dinh et al. (2017): This paper introduces a technique called Real Non-Volume Preserving (Real NVP) flows, which is a type of normalizing flow that can be used to model complex high-dimensional probability distributions. Real NVP is an important building block of GDM, as it provides a way of modeling the complex dynamics of the diffusion process that is used in GDM.
>
> "Generative Models and Model Criticism via Optimized Maximum Mean Discrepancy" by Dougal Maclaurin et al. (2015): This paper introduces a technique called Maximum Mean Discrepancy (MMD), which is a way of comparing probability distributions based on their mean embeddings. MMD is an important tool in the evaluation of generative models, as it provides a way of quantifying the quality of the generated samples.
>
> "Improved Techniques for Training GANs" by Tim Salimans et al. (2016): This paper introduces several techniques for training Generative Adversarial Networks (GANs), which are another type of generative model that is closely related to GDM. Many of the techniques introduced in this paper, such as minibatch discrimination and virtual batch normalization, can be applied to GDM to improve its performance.
>
>"Denoising Diffusion Probabilistic Models" by Jonathan Ho et al. (2020): This paper introduces a technique called Denoising Diffusion Probabilistic Models (DDPM), which is a variant of GDM that is designed to improve the quality of the generated samples. DDPM adds a denoising step to the diffusion process used in GDM, which can lead to higher quality samples and faster convergence.
>
> These are just a few examples of the important literature that can be useful in the development of GDM. There are many other papers and techniques that can be helpful as well, depending on the specific application and requirements of the model.

</small>

</details>

<details><summary>ChatGPT (Legacy)</summary>

<small>

> The development of generative diffusion models has been an active area of research in recent years, and there have been several important papers in this field. Here are some of the most influential papers in the development of generative diffusion models:
> 
> Variational Inference for Diffusion Processes (2018), by Johannes Johansson, Fredrik Lindsten, and Thomas B. Schön
> 
> Neural SDEs (2019), by Yingzhen Li, Jian Guo, and Yves-Alexandre de Montjoye
> 
> Scaling Limits of Diffusion-Type Models for Generative Learning (2019), by Hanjun Dai, Bo Dai, and Le Song
> 
> Generative Diffusion Models (2020), by Yao Liu, Jiaming Song, Stefano Ermon, and Le Song
> 
> Diffusion Generative Adversarial Networks (2021), by Wei-Cheng Chang, Bo Dai, and Le Song
> 
> These papers provide a foundation for the development of generative diffusion models and demonstrate the effectiveness of these models in various applications, including generative learning, generative adversarial networks, and variational inference. These papers have helped to advance the field of generative diffusion models and have inspired many other researchers to pursue further work in this area.

</small>

</details>

<details><summary>GPT-4</summary>

<small>

> Generative diffusion models have advanced significantly in recent years, and their development is rooted in a number of important papers and literature in the field. Here are some key publications that have contributed to the development of generative diffusion models:
> 
> Denosing Score Matching and the SDEs (Song, J., Zhao, S., & Ermon, S., 2021): This paper introduces a training principle called denoising score matching (DSM) for generative models, which learns score functions of the data distribution by training on pairs of noisy and clean data points. The paper also provides a connection between DSM and stochastic differential equations (SDEs), which paved the way for generative diffusion models.
> 
> Score-Based Generative Modeling through Stochastic Differential Equations (Song, J., Zhou, Y., Zhao, S., & Ermon, S., 2021): This paper extends the idea of denoising score matching and SDEs and provides a framework for score-based generative modeling with SDEs, which is the foundation of generative diffusion models.
> 
> NCSN++: Analyzing and Improving Neural Conditional Score Networks (Denoising Diffusion Probabilistic Models) (Song, J., Zhao, S., & Ermon, S., 2021): This paper investigates the properties of denoising score networks and provides several techniques for improving their performance, including architectural changes and multi-scale training.
> 
> Improved Denoising Diffusion Probabilistic Models (Dhariwal, P., & Nichol, A., 2021): This paper introduces several advancements for denoising diffusion probabilistic models, such as improved training techniques and better hyperparameters that result in state-of-the-art performance on image synthesis tasks.
> 
> On the Connection Between Denosing Score Matching and Contrastive Divergence (Grathwohl, W., Song, J., Zhao, S., & Ermon, S., 2021): This work explores the connections between denoising score matching (DSM) and contrastive divergence (CD), which is another popular approach for training energy-based models. The paper shows that DSM can be interpreted as a special case of CD with a particular choice of noise distribution.
> 
> These publications, among others, have played a pivotal role in the development and understanding of generative diffusion models. As the field continues to progress, further advancements are likely to emerge from both foundational research and practical applications.

</small>

</details>

<details><summary>New Bing</summary>

<small>

> Hello, this is Bing. I can help you find some literature on generative diffusion model. Generative diffusion model is a powerful new type of deep generative model that has achieved record-breaking performance in many applications, such as image synthesis, video generation, and molecule design [[1]](https://arxiv.org/abs/2209.00796). Some important papers on this topic are:
>
> A Survey on Generative Diffusion Model [[2]](https://arxiv.org/abs/2209.02646), which provides a comprehensive overview of the methods and applications of generative diffusion model.
> Diffusion Models: A Comprehensive Survey of Methods and Applications [[1]](https://arxiv.org/abs/2209.00796), which categorizes the research on diffusion models into three key areas: efficient sampling, improved likelihood estimation, and conditional generation.
> Variational Diffusion Models [[3]](https://arxiv.org/abs/2107.00630), which introduces a family of diffusion-based generative models that obtain state-of-the-art likelihoods on standard image density estimation benchmarks.
> I hope this helps you with your research.😊
>
> For more information: [arxiv.org](https://arxiv.org/abs/2209.00796) [arxiv.org](https://arxiv.org/abs/2209.02646) [arxiv.org](https://arxiv.org/abs/2107.00630)

</small>

</details>

<details><summary>Notion AI</summary>

<small>

> In order to enhance the development process of generative diffusion model, it is important to consider the following literature:
> 
> - "Causal Inference in Statistics: An Overview" by Judea Pearl
> - "Counterfactual Fairness" by Matt Kusner et al.
> - "The Do-Calculus Revisited" by Jonas Peters et al.
> 
> These resources provide valuable insights and methodologies for understanding causal relationships and making predictions based on causal inference. By incorporating these concepts into the generative diffusion model, we can improve the accuracy and effectiveness of the model in predicting outcomes and understanding the underlying causal mechanisms.
> 
> It is important to note that causal inference is a complex and evolving field, and continued research and development is necessary to fully leverage its potential in data science and machine learning.

</small>

</details>

#### Performance

<small>

Due to the assistance of search engines, New Bing can provide the latest and most authentic reference documents. However, the GPT series models can only provide documents up to September 2021, and only the articles provided by GPT-4 are most relevant to the requirements. In comparison, the articles provided by Notion AI completely deviate from my needs.

</small>

### Time-awareness and connectivity

<small>

> What is today's date and day of the week? How is the weather?

</small>

<details><summary>ChatGPT (Default)</summary>

<small>

> Today's date is March 19th, 2023. It is a Sunday.
> 
> As an AI language model, I do not have direct access to the current weather conditions. However, I can suggest that you check a weather website or app for the most up-to-date weather information in your location.

</small>

</details>

<details><summary>ChatGPT (Legacy)</summary>

<small>

> Today's date is March 19th, 2023. The day of the week is Saturday. As an AI language model, I don't have the ability to access real-time information about the weather. But you can check a weather website or app for the most up-to-date information.

</small>

</details>

<details><summary>GPT-4</summary>

<small>

> Today's date is March 19, 2023, and it is a Sunday. As an AI language model, I do not have real-time information or the ability to access current weather conditions. Please check a local weather source or a weather website for up-to-date information on the weather in your area.

</small>

</details>

<details><summary>New Bing</summary>

<small>

> Hello, this is Bing. I can help you find out today’s date and day of the week. According to [[1]](https://www.calendardate.com/todays.htm), today’s date is **Friday March 17, 2023**. It is the **77th** day of the year, the **11th** week of the year, and the **3rd** month of the year. It is also a leap year and daylight saving time is in effect.
> 
> To answer your second question, I need to know your location or zip code so I can search for the weather information. Can you please tell me where you are?
>
> For more information: [calendardate.com](https://www.calendardate.com/todays.htm) [timeanddate.com](https://www.timeanddate.com/) [rapidtables.com](https://www.rapidtables.com/tools/todays-date.html)

</small>

</details>

<details><summary>Notion AI</summary>

<small>

> Today is {insert date} and it is {insert day of the week}. As for the weather, it is {insert current weather condition}.

</small>

</details>

#### Performance

<small>

Notion AI is unable to retrieve time and network information completely. It is unclear how the GPT series models can identify time (although ChatGPT Legacy version provides time with a one-day deviation). As expected, New Bing knows today's time. After providing location information, New Bing can also naturally obtain weather information. However, other models can only provide websites for obtaining weather information.

</small>

### Comparison and Analysis of Application Scenarios

Based on the above experiments, we can summarize the capabilities of various LLM models as follows.

| Model             | Photosynthesis Explanation  | Interaction Style        | Text Matching & Replacement | Reference Docs    | Reference Accuracy | Time & Network Info |
| ----------------- | --------------------------- | ------------------------ | --------------------------- | ----------------- | ------------------ | -------------------- |
| ChatGPT (Default) | Comprehensive, detailed     | Conversational, informative | Partially met               | Up to Sep 2021    | Moderate           | Partially met        |
| ChatGPT (Legacy)  | Simpler explanation         | Conversational, informative | Partially met               | Up to Sep 2021    | Moderate           | Partially met        |
| GPT-4             | Comprehensive, detailed     | Conversational, informative | Fully met                   | Up to Sep 2021    | Good               | Partially met        |
| New Bing          | Brief summary               | Search-oriented             | Partially met               | Latest & authentic| Excellent          | Fully met            |
| Notion AI         | General description         | Conversational, less detailed | Partially met           | Irrelevant        | Poor               | Not met              |

Once again, it should be emphasized that the capabilities mentioned here are only representative parts of the overall capabilities of LLMs. The purpose of this article is not to list all their possible applications, but to make readers aware that different LLMs have their respective strengths and work in different ways.

## Takeaways{#takeaways}

- When you want to **understand a professional concept**, the **GPT series** can provide you with the most direct and easy-to-understand explanation. When you want to further deepen your understanding, **New Bing** can help you better find related professional literature.
- When you need to follow **specific steps to solve a problem**, and you **don't necessarily need to understand the underlying principles**, such as installing an operating system as a designer, **GPT series** can provide you with detailed step-by-step instructions.
- If you need to proofread, perform regular expression replacement, summarize, rewrite or perform other tasks on **long texts**, it is highly recommended to use **GPT-4**.
- If you need to search for professional literature or other content where **authenticity** is crucial, it is recommended to use **New Bing**.
- If you need to access **real-time content**, it is recommended to use **New Bing**.
- If you need to perform **context-based modification**, refinement or make **daily records** based on a piece of your own written text, it is recommended to use **Notion AI**.

## Conclusion

Overall, ChatGPT and GPT-4 performed exceptionally well across all tasks, showcasing their versatility and effectiveness in various use cases. New Bing is a reliable choice for information retrieval and summarization, but it may not be the best option for creative or opinion-based tasks. Notion AI, while offering valuable assistance within its platform, may not be the most suitable choice for more in-depth or technical inquiries.

Ultimately, the choice of LLM will depend on your specific needs and preferences. If you're looking for an all-rounder with strong performance in diverse tasks, ChatGPT and GPT-4 are excellent choices. For focused research and summarization, New Bing is a reliable option. If you're already a Notion user and need assistance within the platform, Notion AI can help improve your productivity.

Apart from the inherent abilities of LLMs, there are various applications designed based on these abilities, such as New Bing and Notion AI, which have brought convenience to people's lives in different ways. However, there are still many needs for specific product designs, such as personalized products that can capture a user's interaction history to better understand their needs and preferences for more efficient conversations. Nonetheless, such products must address privacy concerns. It is hoped that similar products will be developed to solve these issues and made available to everyone.