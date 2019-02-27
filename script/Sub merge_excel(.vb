Sub merge_excel()

Dim FileOpen

Dim X As Integer

Application.ScreenUpdating = False

FileOpen = Application.GetOpenFilename(FileFilter:="Microsoft ExcelFile(*.xlsx),*.xlsx", MultiSelect:=True, Title:="merge")

X = 1

While X <= UBound(FileOpen)

Workbooks.Open Filename:=FileOpen(X)

Sheets().Move After:=ThisWorkbook.Sheets(ThisWorkbook.Sheets.Count)

X = X + 1

Wend

ExitHandler:

Application.ScreenUpdating = True

Exit Sub

errhadler:

MsgBox Err.Description

End Sub