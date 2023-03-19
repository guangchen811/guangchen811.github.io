---
title: "Oh My Posh"
date: 2023-03-17
draft: false
tags: 
- PowerShell
- Oh My Posh
---

If you're a Windows user and looking for a way to customize your PowerShell prompt, then Oh My Posh might be just what you need. Oh My Posh is an open-source, community-driven framework for managing your PowerShell prompt configuration. In this tutorial, we will go through the steps to install and configure Oh My Posh.

## Prerequisites
- Windows 10 or above
- PowerShell 5 or above
- .NET Framework 4.7.2 or above
- Git

## Installation
1. Open PowerShell with administrative privileges.
2. Run the following command to install the required modules:
3. Close the PowerShell window.

## Configuration
1. Open PowerShell with administrative privileges.
2. Run the following command to open your PowerShell profile in Notepad: 
```
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
```
3. Close the PowerShell window.

## Configuration
1. Open PowerShell with administrative privileges.
2. Run the following command to open your PowerShell profile in Notepad:
    ```
    notepad $PROFILE
    ```
    If you don't have a profile yet, Notepad will prompt you to create one. Choose "Yes".

1. In Notepad, add the following lines to your profile:
   ```Import-Module posh-git
   Import-Module oh-my-posh
   Set-PoshPrompt -Theme agnoster
   ```
   The first two lines import the required modules, and the third line sets the prompt theme to `agnoster`. You can choose a different theme by replacing `agnoster` with the name of the theme you want to use. A list of available themes can be found on the Oh My Posh GitHub page.

4. Save and close the file.

5. Restart PowerShell.

## Customization
If you want to customize your prompt further, you can create a file named `Microsoft.PowerShell_profile.ps1` in your Documents folder (`C:\Users\<username>\Documents\WindowsPowerShell`), and add your customizations there. This file will be loaded every time you open PowerShell.

For example, you can change the colors of your prompt like this:
```sh
$Colors = @{
'Black' = '#000000'
'DarkGray' = '#808080'
'Blue' = '#0000FF'
'DarkBlue' = '#003366'
'Green' = '#008000'
'DarkGreen' = '#336633'
'Cyan' = '#00FFFF'
'DarkCyan' = '#008B8B'
'Red' = '#FF0000'
'DarkRed' = '#8B0000'
'Magenta' = '#FF00FF'
'DarkMagenta' = '#800080'
'Yellow' = '#FFFF00'
'DarkYellow' = '#808000'
'White' = '#FFFFFF'
'Gray' = '#C0C0C0'
}
Set-PoshPrompt -Colors $Colors
```
This will change the prompt colors to a custom set of colors. You can also add additional modules and customizations to your profile as needed.

Congratulations! You've now installed and configured Oh My Posh. Enjoy your personalized PowerShell prompt!