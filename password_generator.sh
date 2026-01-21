#!/bin/bash

file="passwords.txt"

while true; do 

    echo "========== Password Generator =========="
    echo "1. Generate password 🔐 ====================="
    echo "2. Exit ⬅️ =================================="
    read -p "Enter an option: " option
    sleep 1

    case $option in
    
        1)
            read -p "Enter a length for your password (8-32): " length
            sleep 1

            # Filter generation to ensure the user only enters numbers and that the number is between 8 and 32.
            if [[ ! $length =~ ^[0-9]+$ ]] || [[ $length -lt 8 ]] || [[ $length -gt 32 ]]; then
                echo "Error ❌. Please enter a valid length (8-32)."
                continue
            fi

            read -rp "Include uppercase letters? (y/n): " uppercase
            read -rp "Include numbers? (y/n): " numbers
            read -rp "Include special characters? (y/n): " special
            sleep 1

            # Option filter to ensure the user selects at least one, otherwise the password would be too weak.
            if [[ $uppercase != "y" && $numbers != "y" && $special != "y" ]]; then
                echo "Error ❌. You must include at least one option."
                continue
            fi

            # Character set that the password will contain.
            # By default, the password will contain lowercase letters.
            characters="abcdefghijklmnñopqrstuvwxyz"

            if [[ $uppercase == "y" ]]; then
                characters+="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
            fi
            if [[ $numbers == "y" ]]; then
                characters+="0123456789"
            fi
            if [[ $special == "y" ]]; then
                characters+="!|@·#$%&¬/?¡¿^*+¨ç()[]{}"
            fi

            # Engine that selects the characters for the password.
            password=""
            for (( i = 0; i < length; i++ )); do
                random=$(( RANDOM % ${#characters} ))
                password+="${characters:$random:1}"
            done

            echo "Generating password..."
            sleep 3
            echo "🔐 Password generated!"
            sleep 1
            echo "To use it, access the file 📖 : passwords.txt"
            sleep 1

            # Redirect the generated password to the output file.
            # If the file does not exist, the system creates it.
            echo "$password" >> "$file"
            ;;
        2)
            echo "Exiting the system..."
            sleep 5
            clear
            exit 0
            ;;
        *)
            echo "Error ❌. You selected an incorrect or non-existent option."
            ;;
    esac
done