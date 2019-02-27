{ +--------------------------------------------------------------------------+ }
{ | MMAPI 0.1 * Application programming interface for MMxD device            | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>          | }
{ | mmapi.pas                                                                | }
{ | source code                                                              | }
{ +--------------------------------------------------------------------------+ }

{
  This program is free software: you can redistribute it and/or modify it
under the terms of the European Union Public License 1.1 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.
}

// Uncomment next line if you want to use this as unit.
// {$DEFINE STATIC}

{$MODE OBJFPC}{$H+}

{$IFDEF STATIC}
unit mmapi;
interface
{$ELSE}
library mmapi;
{$ENDIF}
uses
  Classes, SysUtils, httpsend;
var
  devdata: array[0..31] of string;
  devinfo: array[0..2,0..31] of string;
  devuid: pchar;
  devurl: pchar;
  sl : TStringList;
const
  LIBVER: pchar='0.1';

{$IFDEF STATIC}
function address: pchar;
function city: pchar;
function devicedata(line: byte): pchar;
function deviceportsname(line: byte): pchar;
function devicetype: pchar;
function deviceversion: pchar;
function growinghousenumber: pchar;
function uid(id: pchar): pchar;
function url(u: pchar): pchar;
function username: pchar;
function version: pchar;
procedure erasedata;
procedure eraseinfo;
procedure getdata;
procedure getinfo;

implementation
{$ENDIF}

function address: pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  result:=pchar(devinfo[1,2]);
end;

function city: pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  result:=pchar(devinfo[1,1]);
end;

function devicedata(line: byte): pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  if line<32 then
    result:=pchar(devdata[line]);
end;

function deviceportsname(line: byte): pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  if line<32 then
    result:=pchar(devinfo[2,line]);
end;

function devicetype: pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  result:=pchar(devinfo[0,0]);
end;

function deviceversion: pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  result:=pchar(devinfo[0,1]);
end;

procedure runcgi(cgiurl: string);
begin
  with THTTPSend.Create do
  begin
    HttpGetText(cgiurl,sl);
    Free;
  end;
end;

function growinghousenumber: pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  result:=pchar(devinfo[1,3]);
end;

function uid(id: pchar): pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  if length(id)>0
    then devuid:=id
    else result:=devuid;
end;

function url(u: pchar): pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  if length(u)>0
    then devurl:=u
    else result:=devurl;
end;

function username: pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  result:=pchar(devinfo[1,0]);
end;

function version: pchar;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
begin
  result:=LIBVER;
end;

procedure erasedata;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
var
  b: byte;
begin
  for b:=0 to 32 do
    devdata[b]:='';
end;

procedure eraseinfo;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
var
  a, b: byte;
begin
  for a:=0 to 2 do
    for b:=0 to 32 do
      devinfo[a,b]:='';
end;

procedure getdata;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
var
  b: byte;
begin
  sl:=TStringList.Create;
  runcgi(devurl+'?uid='+devuid+'&value=3');
  for b:=0 to 31 do
    try
      devdata[b]:=sl.Strings[b]+#0;
    except
    end;
  sl.Free;
end;

procedure getinfo;
{$IFNDEF STATIC} cdecl; export; {$ENDIF}
var
  b: byte;
  value: byte;
begin
  sl:=TStringList.Create;
  for value:=0 to 2 do
  begin
    runcgi(devurl+'?uid='+devuid+'&value='+inttostr(value));
    for b:=0 to 31 do
    try
      devinfo[value,b]:=sl.Strings[b];
    except
    end;
  end;
  sl.Free;
end;

{$IFNDEF STATIC}
exports address {$IFDEF WIN32} name 'address' {$ENDIF};
exports city {$IFDEF WIN32} name 'city' {$ENDIF};
exports devicedata {$IFDEF WIN32} name 'devicedata' {$ENDIF};
exports deviceportsname {$IFDEF WIN32} name 'deviceportsname' {$ENDIF};
exports devicetype {$IFDEF WIN32} name 'devicetype' {$ENDIF};
exports deviceversion {$IFDEF WIN32} name 'deviceversion' {$ENDIF};
exports growinghousenumber {$IFDEF WIN32} name 'growinghousenumber' {$ENDIF};
exports uid {$IFDEF WIN32} name 'uid' {$ENDIF};
exports url {$IFDEF WIN32} name 'url' {$ENDIF};
exports username {$IFDEF WIN32} name 'username' {$ENDIF};
exports version {$IFDEF WIN32} name 'version' {$ENDIF};
exports erasedata {$IFDEF WIN32} name 'erasedata' {$ENDIF};
exports eraseinfo {$IFDEF WIN32} name 'eraseinfo' {$ENDIF};
exports getdata {$IFDEF WIN32} name 'getdata' {$ENDIF};
exports getinfo {$IFDEF WIN32} name 'getinfo' {$ENDIF};
{$ENDIF}

end.
