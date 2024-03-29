"""
Author: Mike Mitterer <mike@MangoLila.at>
Usage (in einem Modul)
    from version import *
    setup(version=get_git_version())

Usage (cmdline)
    python version.py
"""

__all__ = 'get_git_version'

import os.path
from subprocess import Popen, PIPE


def get_git_version(abbrev=1) -> str:
    """
    Gibt die Version zurück, die mit git tag vX.Y gesetzt wurde.
    Wird keine Version gefunden wird eine Exception geworfen.

    :param abbrev: Anzahl der verwendeten Zeichen der hexadezimalen Commit-ID
    :return: Versions String im Format <Tag>.<Commits> bzw. <Tag>.dev<Commits>
    """

    if not is_git_initialized():
        raise UserWarning(
            ("\n\tCould not determine your git-version!\n"
             "\tGit Repo is not initialized!", 'red')
        )

    try:
        # First try to get the current version using “git describe”.
        version: str = call_git_describe(abbrev)

    except UserWarning as u:
        raise u
    except Exception:
        raise UserWarning(
            ("\n\tCould not determine your git-version!\n"
             "\tHint: check with 'git describe --tags --abbrev=7'", 'red')
        )

    # Finally, return the current version.
    return version


# cmdline: git describe --tags --abbrev=7
def call_git_describe(abbrev) -> str:
    """
    Git-Command wird über Popen aufgerufen.
    Damit wird ermittelt um welche Version bzw. welches Commit es sich handelt

    Entspricht im Prinzip dem Aufruf von
        git describe --tags --abbrev=7

    Sind keine Tags gesetzt, wird Tag 0.0 verwendet und die Anzahl der Commits ermittelt.
        git rev-list --count HEAD

    :param abbrev: Anzahl der verwendeten Zeichen der hexadezimalen Commit-ID
    :return: Versions String im Format <Tag>.<Commits> bzw. <Tag>.dev<Commits>
    """

    process = Popen(['git', 'describe', '--tags', '--abbrev=%d' % abbrev], stdout=PIPE, stderr=PIPE)
    process.stderr.close()

    line = process.stdout.readline()

    if not line:
        process = Popen(['git', 'rev-list', '--count', 'HEAD'], stdout=PIPE, stderr=PIPE)
        process.stderr.close()

        commits = process.stdout.readline()

        if not commits:
            return f'0.0.dev0'

        commits = commits.strip().decode()
        return f'0.0.dev{commits}'

    # v0.2
    line = line.strip().decode()

    # 0.2
    line = line.replace("v", "")

    # In "tag" steht dann z.B. v0.2 und in rest[] die restliche, durch - getrennte Info.
    # Es ist möglich, dass das rest-Array leer ist!
    (tag, *rest) = line.split('-')

    try:
        commits = rest[0]
    except IndexError:
        # Gibt es keine "Batch"-Info (v0.2-2-abc2)
        # Wird ein default Batch von 0 angenommen.
        commits = '0'

    if is_dirty():
        return f'{tag}.dev{commits}'

    return f'{tag}.{commits}'


def is_dirty() -> bool:
    """
    Wenn noch kein Push gemacht wurde, ist die Version "dirty"

    :return: Dirty JA / Nein
    """

    # noinspection PyBroadException
    try:
        process = Popen(["git", "diff-index", "--name-only", "HEAD"],
                        stdout=PIPE, stderr=PIPE)
        process.stderr.close()
        lines = process.stdout.readlines()
        return len(lines) > 0

    except Exception:
        return False


def is_git_initialized() -> bool:
    """
    Überprüft ob es sich bei dem aktuellen Projekt um ein Git Repo handelt.
    Der .git Folder muss dazu vorhanden sein.

    :return: Git Initialisiert JA / Nein
    """
    if os.path.isdir('.git'):
        return True

    return False


if __name__ == "__main__":
    print(get_git_version())
