{
  LaKraven Studios Standard Library [LKSL]
  Copyright (c) 2014, LaKraven Studios Ltd, All Rights Reserved

  Original Source Location: https://github.com/LaKraven/LKSL

  License:
    - You may use this library as you see fit, including use within commercial applications.
    - You may modify this library to suit your needs, without the requirement of distributing
      modified versions.
    - You may redistribute this library (in part or whole) individually, or as part of any
      other works.
    - You must NOT charge a fee for the distribution of this library (compiled or in its
      source form). It MUST be distributed freely.
    - This license and the surrounding comment block MUST remain in place on all copies and
      modified versions of this source code.
    - Modified versions of this source MUST be clearly marked, including the name of the
      person(s) and/or organization(s) responsible for the changes, and a SEPARATE "changelog"
      detailing all additions/deletions/modifications made.

  Disclaimer:
    - Your use of this source constitutes your understanding and acceptance of this
      disclaimer.
    - LaKraven Studios Ltd and its employees (including but not limited to directors,
      programmers and clerical staff) cannot be held liable for your use of this source
      code. This includes any losses and/or damages resulting from your use of this source
      code, be they physical, financial, or psychological.
    - There is no warranty or guarantee (implicit or otherwise) provided with this source
      code. It is provided on an "AS-IS" basis.

  Donations:
    - While not mandatory, contributions are always appreciated. They help keep the coffee
      flowing during the long hours invested in this and all other Open Source projects we
      produce.
    - Donations can be made via PayPal to PayPal [at] LaKraven (dot) Com
                                          ^  Garbled to prevent spam!  ^
}
unit LKSL_Settings_Groups;

{
  About this unit: (FPC/Lazarus)
    - This unit provides the objects that contain groups of key/value pairs.

  Changelog (newest on top):
    3rd October 2014:
      - Initial Scaffolding
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LKSL_Settings_Fields;

type
  {
    TLKSettingsGroup
      - Implements a container for a simple group of key/value pairs.
  }
  TLKSettingsGroups = class; // Forward class
  TLKSettingsGroup = class(TComponent)
  private
    FGroupName: String;
    FDisplayName: String;
    FSettingsFields: TLKSettingsFields;
    FSettingsGroups: TLKSettingsGroups;
    function GetSettingsField(Index: Integer): TLKSettingsField;
    function GetSettingsGroup(Index: Integer): TLKSettingsGroup;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Fields[Index: Integer]: TLKSettingsField read GetSettingsField; default;
    property Groups[Index: Integer]: TLKSettingsGroup read GetSettingsGroup;
  published
    property GroupName: String read FGroupName write FGroupName;
    property DisplayName: String read FDisplayName write FDisplayName;
  end;

  TLKSettingsGroupClass = class of TLKSettingsGroup;

  {
    TLKSettingsGroups
      - Implements a container for a list of TLKSettingsGroup with many levels.
  }

  TLKSettingsGroups = class(TComponent)
  private
    FSettingsGroupItems: TFPList;
    function GetCount: Integer;
    function GetSettingsGroup(Index: Integer): TLKSettingsGroup;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Add(AGroup: TLKSettingsGroup): Integer;
    procedure Delete(AGroup: TLKSettingsGroup);
    procedure Delete(AIndex: Integer); overload;
    procedure Clear;

    property Items[Index: Integer]: TLKSettingsGroup read GetSettingsGroup; default;
    property Count: Integer read GetCount;
  published
  end;

  TLKSettingsGroupsClass = class of TLKSettingsGroups;

{
  Register
    - Procedure to register component on the component bar
}

procedure Register;

implementation

procedure Register;
begin
  // Will need to register the property editors for Groups
end;

{ TLKSettingsGroup }

function TLKSettingsGroup.GetSettingsField(Index: Integer): TLKSettingsField;
begin
  Result:= TLKSettingsField(FSettingsFields[Index]);
end;

function TLKSettingsGroup.GetSettingsGroup(Index: Integer): TLKSettingsGroup;
begin
  Result:= TLKSettingsGroup(FSettingsGroups[Index]);
end;

constructor TLKSettingsGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSettingsFields:= TLKSettingsFields.Create(Self);
  FSettingsGroups:= TLKSettingsGroups.Create(Self);
end;

destructor TLKSettingsGroup.Destroy;
begin
  if Assigned(FSettingsFields) then
  begin
    FSettingsFields.Free;
  end;
  if Assigned(FSettingsGroups) then
  begin
    FSettingsGroups.Free;
  end;
  inherited Destroy;
end;

{ TLKSettingsGroups }

function TLKSettingsGroups.GetSettingsGroup(Index: Integer): TLKSettingsGroup;
begin
  Result:= TLKSettingsGroup(FSettingsGroupItems[Index]);
end;

function TLKSettingsGroups.GetCount: Integer;
begin
  Result:= FSettingsGroupItems.Count;
end;

constructor TLKSettingsGroups.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSettingsGroupItems:= TFPList.Create;
end;

destructor TLKSettingsGroups.Destroy;
var
  Index: Integer;
begin
  if Assigned(FSettingsGroupItems) then
  begin
    for Index:= FSettingsGroupItems.Count - 1 downto 0 do
    begin
      if Assigned(FSettingsGroupItems[Index]) then
      begin
        TLKSettingsGroup(FSettingsGroupItems[Index]).Free;
      end;
      FSettingsGroupItems.Delete(Index);
    end;
  end;
  FSettingsGroupItems.Free;
  inherited Destroy;
end;

function TLKSettingsGroups.Add(AGroup: TLKSettingsGroup): Integer;
begin
  Result:= FSettingsGroupItems.Add(AGroup);
end;

procedure TLKSettingsGroups.Delete(AGroup: TLKSettingsGroup);
var
  Index: Integer;
begin
  for Index:= 0 to FSettingsGroupItems.Count - 1 do
  begin
    if AGroup = TLKSettingsGroup(FSettingsGroupItems[Index]) then
    begin
      TLKSettingsGroup(FSettingsGroupItems[Index]).Free;
      FSettingsGroupItems.Delete(Index);
      break;
    end;
  end;
end;

procedure TLKSettingsGroups.Delete(AIndex: Integer);
begin
  FSettingsGroupItems.Delete(AIndex);
end;

procedure TLKSettingsGroups.Clear;
var
  Index: Integer;
begin
  for Index:= FSettingsGroupItems.Count - 1 downto 0 do
  begin
    if Assigned(FSettingsGroupItems[Index]) then
    begin
      TLKSettingsGroup(FSettingsGroupItems[Index]).Free;
    end;
    FSettingsGroupItems.Delete(Index);
  end;
end;

end.

