# Hello World Package

## Generate Package
> [Publishing (Perfect) Python Packages on PyPi](https://www.youtube.com/watch?v=GIF3LaRqgXo&t=4s)

    # Activate VENV
    source ./venv/bin/activate

    # Generates 'dist'-Folder
    python3 setup.py bdist_wheel

    # Neben dem Dist-Folder wird auch der egg-info-Folder generiert
    # Dieser Folder interessiert uns weiter nicht
    "Hello_World_Package.egg-info" >> .gitignore

## Documentation

## Install

## Usage

## Testing
Damit die Tests auf der cmdline laufen wird `pip install pytest` benötigt

    pytest tests

### requirement.txt
Ist hier eigentlich nicht notwendig!

    # Freeze des aktuellen Standes
    pip freeze > requirements.txt

    # Installation des Standes in requirements
    pip install --use-deprecated=legacy-resolver -r requirements.txt

    # Diese Variante hat noch (4.9.21) Probleme mit dem resolver
    # Hängt...
    pip install -r requirements.txt