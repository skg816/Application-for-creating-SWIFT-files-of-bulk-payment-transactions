{------------------------------------------------------------------------------
                         Defines and Compiler Flags

       gs6_flag Copyright (c) 2002 Griffin Solutions, Inc.

       Date
          19 Sep 2002

       Programmer:
          Richard F. Griffin                     tel: (478) 953-2680
          Griffin Solutions, Inc.             e-mail: halcyon@grifsolu.com
          102 Molded Stone Pl
          Warner Robins, GA  31088

       -------------------------------------------------------------
       This unit handles the defines and compiler flags that are used
       to configure the compiler.  It is included ($I GS6_FLAG.PAS) in
       each unit.

   Changes:

------------------------------------------------------------------------------}

{$IFDEF LINUX}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
{$ENDIF}

// Delphi 4
{$IFDEF VER120}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE DELPHI}
  {$DEFINE DELPHI4}
{$ENDIF}

// C++ Builder 4
{$IFDEF VER125}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE CBUILDER}
  {$DEFINE CBUILDER4}
{$ENDIF}

// Delphi 5 & CBuilder 5
{$IFDEF VER130}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$IFDEF BCB}
    {$DEFINE CBUILDER}
    {$DEFINE CBUILDER5}
  {$ELSE}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI5}
  {$ENDIF}
{$ENDIF}

//Delphi 6
{$IFDEF VER140}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$IFDEF BCB}
    {$DEFINE CBUILDER}
    {$DEFINE CBUILDER6}
  {$ELSE}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI6}
  {$ENDIF}
{$ENDIF}

//Delphi 7
{$IFDEF VER150}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$IFDEF BCB}
    {$DEFINE CBUILDER}
    {$DEFINE CBUILDER6}
  {$ELSE}
    {$DEFINE DELPHI}
    {$DEFINE DELPHI7}
  {$ENDIF}
{$ENDIF}

{$IFDEF WIN32}
   {$IFNDEF MSWINDOWS}
      {$DEFINE MSWINDOWS}
   {$ENDIF}
{$ENDIF}

{$IFDEF VCL4ORABOVE}
   {$DEFINE HASINT64}    {Allow Int64 if not Delphi 3}
{$ENDIF}


{$IFNDEF NOFOXGEN}
   {$DEFINE FOXGENERAL}   {Set General Collate mode for FoxPro}
{$ENDIF}

{$IFNDEF NODBASE3}
   {$DEFINE DBASE3OK}     {Include DBase 3 index code}
{$ENDIF}

{$IFNDEF NODBASE4}
   {$DEFINE DBASE4OK}     {Include DBase 4 index code}
{$ENDIF}

{$IFNDEF NOCLIP}
   {$DEFINE CLIPOK}       {Include Clipper index code}
{$ENDIF}

{$IFNDEF NOFOX}
   {$DEFINE FOXOK}        {Include FoxPro index code}
{$ENDIF}

{$OPTIMIZATION ON}      {Enables or disables the use of optimization}
{$ALIGN ON}             {Switches between byte/word alignment of variables and typed constants}
{$IOCHECKS ON}          {Enables or disables the automatic code generation that checks the}
                        {result of a call to an I/O procedure}
{$VARSTRINGCHECKS ON}   {Controls type-checking on strings passed as variable parameters}
{$TYPEDADDRESS OFF}     {Controls Type @ Operator}
{$BOOLEVAL OFF}         {Switches between the two different models of code generation for the}
                        {AND and OR Boolean operators}
{$EXTENDEDSYNTAX ON}    {Enables or disables extended syntax}


{$IFNDEF NOFOXGEN}
   {$DEFINE FOXGENERAL}   {Set General Collate mode for FoxPro}
{$ENDIF}

{$IFNDEF NODBASE3}
   {$DEFINE DBASE3OK}     {Include DBase 3 index code}
{$ENDIF}

{$IFNDEF NODBASE4}
   {$DEFINE DBASE4OK}     {Include DBase 4 index code}
{$ENDIF}

{$IFNDEF NOCLIP}
   {$DEFINE CLIPOK}       {Include Clipper index code}
{$ENDIF}

{$IFNDEF NOFOX}
   {$DEFINE FOXOK}        {Include FoxPro index code}
{$ENDIF}

{$OPTIMIZATION ON}      {Enables or disables the use of optimization}
{$ALIGN ON}             {Switches between byte/word alignment of variables and typed constants}
{$IOCHECKS ON}          {Enables or disables the automatic code generation that checks the}
                        {result of a call to an I/O procedure}
{$VARSTRINGCHECKS ON}   {Controls type-checking on strings passed as variable parameters}
{$TYPEDADDRESS OFF}     {Controls Type @ Operator}
{$BOOLEVAL OFF}         {Switches between the two different models of code generation for the}
                        {AND and OR Boolean operators}
{$EXTENDEDSYNTAX ON}    {Enables or disables extended syntax}

