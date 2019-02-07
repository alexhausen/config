#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
; C:\Users\alh\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

<^>!q::send, {Home}
<^>!e::send, {End}

<^>!w::send, {Up}
<^>!a::send, {Left}
<^>!s::send, {Down}
<^>!d::send, {Right}

<^>!+w::send, +{Up}
<^>!+a::send, +{Left}
<^>!+s::send, +{Down}
<^>!+d::send, +{Right}

^<^>!w::send, ^{Up}
^<^>!a::send, ^{Left}
^<^>!s::send, ^{Down}
^<^>!d::send, ^{Right}
