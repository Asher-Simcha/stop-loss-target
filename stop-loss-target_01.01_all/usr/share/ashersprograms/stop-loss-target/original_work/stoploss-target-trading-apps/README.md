# Stop Loss and Target Calculator

## Introduction

This script automates the setup of a keyboard shortcut in XFCE to calculate and display stop loss and target prices for trades. It's designed to simplify the process for traders using XFCE desktop environments.

## Prerequisites

- **XFCE Desktop Environment**: Required for setting up keyboard shortcuts using `xfconf-query`.
- **Zenity**: Necessary for graphical user input and output.
- **BC Calculator**: Used for basic arithmetic calculations.

## Installation

1. **Download**: Obtain the `stop_loss_target_calculator.sh` file.
2. **Grant Permissions**: In the terminal, navigate to the downloaded directory and make the script executable:

    ```bash
    chmod +x stop_loss_target_calculator.sh
    ```

3. **Run the Script**: Execute the script by running:

    ```bash
    ./stop_loss_target_calculator.sh
    ```

## Usage

1. Ctrl+Alt+Z or run the script manually
2. Enter the buy price, stop loss points, and target points when prompted.
3. The script will calculate stop loss and target prices if all values are entered.
4. The results will be displayed in a graphical interface and saved to `~/.conky/NeatInfo/addons/note.txt`.
5. NeatInfo Conky theme link: [Download.](https://github.com/somen3/NeatInfo/releases/download/conky/NeatInfo.zip)


