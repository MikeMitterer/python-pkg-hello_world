# Hello World Package

## Generate Package
> [Publishing (Perfect) Python Packages on PyPi](https://www.youtube.com/watch?v=GIF3LaRqgXo&t=4s)

    # Activate VENV
    source ./venv/bin/activate

    # Generates 'dist'-Folder
    python3 setup.py bdist_wheel

    # Generates 'dist'-Folder INKLUSIVE x.tar.gz-File!
    python3 setup.py bdist_wheel sdist

    # Neben dem Dist-Folder wird auch der egg-info-Folder generiert
    # Dieser Folder interessiert uns weiter nicht
    "Hello_World_Package.egg-info" >> .gitignore

### Manifest-File
    
    # Damit kann das Manifest überprüft werden.
    pip install check-manifest

    # Manifest wird erstellt
    check-manifest --create

    # Überprüfen den Manifest-Files
    check-manifest

## Documentation

## Install

### From GitHub

    # Version muss hier upgegradet werden!!!!!
    python -m pip install https://github.com/MikeMitterer/python-pkg-hello_world/blob/master/dist/Hello-World-Package-0.0.2.tar.gz?raw=true

## Usage

    python
    >>> import hello_world.cli
    >>> hello_world.cli.hello()
    >>> exit()

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