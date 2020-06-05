from tkinter import *
from tkinter import ttk
from PIL import Image, ImageTk
import cv2
import argparse
import sys
import os
#
root = Tk()
opcijas=Tk()
root.title('galvenais')
opcijas.title('opcijas')
#
app = Frame(root, bg="white")
app.grid()
#
logs= Label(app)
logs.grid()
#
cascade_face=('/Users/jodmi/OneDrive/Desktop/python-based-face-detection/Data/haarcascade_frontalface_alt.xml')
cascade_eye=('/Users/jodmi/OneDrive/Desktop/python-based-face-detection/Data/haarcascade_eye.xml')
cascade_eye_glasses=('/Users/jodmi/OneDrive/Desktop/python-based-face-detection/Data/haarcascade_eye_tree_eyeglasses.xml')
cascade_fullbody=('/Users/jodmi/OneDrive/Desktop/python-based-face-detection/Data/haarcascade_fullbody.xml')
cascade_lowerbody=('/Users/jodmi/OneDrive/Desktop/python-based-face-detection/Data/haarcascade_lowerbody.xml')
cascade_smile=('/Users/jodmi/OneDrive/Desktop/python-based-face-detection/Data/haarcascade_smile.xml')

#
cap = None
must_exit = False
exited = False
start_button = None
pause_button = None

cascade = None

# Izsekosana      strada
def detectAndDisplay():
    if must_exit:
        global exited
        exited = True
        return
    parser = argparse.ArgumentParser(description='Trackinga faili')
    parser.add_argument('--chosen_cascade', default=saraksts.get())# kādu tracking bbiblioteku izmantosim
    args = parser.parse_args()
    cascade_name = args.chosen_cascade
    global cascade
    cascade= cv2.CascadeClassifier()
    cascade.load(cv2.samples.findFile(cascade_name))
    _, frame = cap.read()
    cv2image = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    frame_gray = cv2.equalizeHist(cv2image)
    #-- Detect faces
    faces = cascade.detectMultiScale(frame_gray) #Detects objects of different sizes in the input image. The detected objects are returned as a list of rectangles. 
    for (x,y,w,h) in faces:
        center = (x + w//2, y + h//2)
        frame = cv2.ellipse(frame, center, (w//2, h//2), 0, 0, 360, (255, 0, 255), 4)
        faceROI = frame_gray[y:y+h,x:x+w]
    frame2 = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    img = Image.fromarray(frame2)
    imgtk = ImageTk.PhotoImage(image=img)
    logs.imgtk = imgtk
    logs.configure(image=imgtk)
    logs.after(100, detectAndDisplay)


def start():
    global start_button
    start_button.configure(state=DISABLED)
    pause_button.configure(state=NORMAL)
    global cap
    if not cap:
        cap = cv2.VideoCapture(0)
    elif not cap.isOpened():
        cap.open(0)
    global must_exit
    must_exit = False
    global exited
    exited = False
    detectAndDisplay()


#Restart (pythons  vajag tikkai kodu, iespejam ka bez koda restarta nevares mainit kaskades!!!!!!!!!!!!!!!!)
def restart_program():  
    python = sys.executable
    os.execl(python, python, * sys.argv)


def pause():
    pause_button.configure(state=DISABLED)
    global must_exit
    must_exit = True
    if not exited:
        logs.after(100, pause)
    global cap
    cap.release()
    start_button.configure(state=NORMAL)

#Pogas
start_button = Button(opcijas, text='palaist', width=15, command=start)
start_button.grid(row=1, sticky=W )
Button(opcijas, text='izslegt', width=15, command=restart_program).grid(row=2, sticky=W)
pause_button = Button(opcijas, text='pause', width=15, command=pause, state=DISABLED)
pause_button.grid(row=3, sticky=W)


#
saraksts = ttk.Combobox(opcijas, values=[cascade_face,cascade_eye,cascade_eye_glasses,cascade_fullbody,cascade_lowerbody,cascade_smile], width=60)
saraksts.grid(column=0, row=4)
saraksts.current(0)

root.mainloop()

