# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

# You can import any python module as needed.
import os

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!


class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()
#class delete(Command):
#    """:delete
#
#    Tries to delete the selection or the files passed in arguments (if any).
#    The arguments use a shell-like escaping.
#
#    "Selection" is defined as all the "marked files" (by default, you
#    can mark files with space or v). If there are no marked files,
#    use the "current file" (where the cursor is)
#
#    When attempting to delete non-empty directories or multiple
#    marked files, it will require a confirmation.
#    """
#
#    allow_abbrev = False
#    escape_macros_for_shell = True
#
#    def execute(self):
#        import os
#        import shlex
#        from functools import partial
#        from ranger.container.file import File
#
#        def is_directory_with_files(f):
#            import os.path
#            return (os.path.isdir(f) and not os.path.islink(f)
#                and len(os.listdir(f)) > 0)
# 
#        if self.rest(1):
#            files = shlex.split(self.rest(1))
#            many_files = (len(files) > 1 or is_directory_with_files(files[0]))
#        else:
#            cwd = self.fm.thisdir
#            cf = self.fm.thisfile
#            if not cwd or not cf:
#                self.fm.notify("Error: no file selected for deletion!", bad=True)
#                return
#
#            # relative_path used for a user-friendly output in the confirmation.
#            files = [f.relative_path for f in self.fm.thistab.get_selection()]
#            many_files = (cwd.marked_items or is_directory_with_files(cf.path))
#            blacklist = ['<Directory /home/chris/test>']
#            if not set(self.fm.thistab.get_selection()).isdisjoint(blacklist):
#                self.fm.notify('test')
#        confirm = self.fm.settings.confirm_on_delete
#        if confirm != 'never' and (confirm != 'multiple' or many_files):
#            filename_list = files
#            self.fm.ui.console.ask("Confirm deletion of: %s (y/N)" %
#                ', '.join(files),
#                partial(self._question_callback, files), ('n', 'N', 'y', 'Y'))
#        else:
#            # no need for a confirmation, just delete
#            self.fm.delete(files)
#
#    def tab(self, tabnum):
#        return self._tab_directory_content()
#
#    def _question_callback(self, files, answer):
#        if answer == 'y' or answer == 'Y':
#            self.fm.delete(files)
