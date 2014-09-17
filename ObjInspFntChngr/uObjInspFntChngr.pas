unit uObjInspFntChngr;

interface

procedure Register;

implementation

uses
  Windows, Classes, SysUtils,
  VCL.Graphics, VCL.Controls, VCL.Forms;

var
  FSavedFont: TFont;

const
  PreferFontName = 'Tahoma';
  PreferFontSize = 8;

function FindObjectInspecotr: TCustomForm;
var
  I: Integer;
begin
  for I := 0 to Screen.CustomFormCount - 1 do
    if Screen.CustomForms[I].Name = 'PropertyInspector' then
    begin
      Result := Screen.CustomForms[I];
      Exit;
    end;
  Result := nil;
end;

procedure Register;
var
  F: TCustomForm;
begin
  F := FindObjectInspecotr;
  if Assigned(F) then
  begin
    FSavedFont := TFont.Create;
    FSavedFont.Assign(F.Font);

    F.Font.Name := PreferFontName;
    F.Font.Size := PreferFontSize;
  end;
end;

procedure Unregister;
var
  F: TCustomForm;
begin
  if Assigned(FSavedFont) then
  begin
    F := FindObjectInspecotr;
    if Assigned(F) then
      F.Font.Assign(FSavedFont);
  end;

  FreeAndNil(FSavedFont);
end;

initialization

finalization
  Unregister;
end.
