#!/usr/bin/python3

#A very basic imitation using python and Qt5 of Unity DE-s OS hotkey cheatsheet which used to be displayed after holding Super (/Win/Meta/Command/mod4Mask) key for a second or two and closed at the release of said key.
#You probably need Qt5 installed one way or another. What worked for me (after having installed pip) was `pip3 install --user pyqt5`

#2017-11-27 Ver 1.0 Considered removing titlebar and closing it on unfocus and renaming process, but didnt have enough time (sleep pls).
#2017-11-27 Ver 1.1 Added font scaling.



import sys
from PyQt5.QtWidgets import QWidget, QDesktopWidget, QLabel, QApplication, QPlainTextEdit
from PyQt5.QtCore import QFile, QIODevice, QTextStream, Qt

file_path = './hotkey cheatsheet'

class Example(QWidget):

    def __init__(self):
        super().__init__()

        self.initUI()
        #self.setWindowFlags(Qt.FramelessWindowHint)
        #ui.setWindowFlags(Qt.Window | Qt.FramelessWindowHint)


    def initUI(self):

        font1 = self.font()
        font1.setPointSize(QDesktopWidget().availableGeometry().height()/60)
        self.setFont(font1)

        text=open(file_path).read()
        lbl1 = QLabel(text, self)

        self.setWindowTitle('Hotkeys')
        self.show()
        self.adjustSize()
        hsize = (QDesktopWidget().availableGeometry().width() / 6 * 5)
        self.setMinimumWidth(hsize)
        self.center()
        self.setWindowOpacity(0.95)


    def center(self):

        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())

    #def focusOutEvent(self, event):

        #print ("trying")
        #sys.exit()


if __name__ == '__main__':

    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())
