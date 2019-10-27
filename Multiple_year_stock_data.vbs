Sub StocksAnalysis():

Dim Ticker As String
Dim IRowCount As Integer
Dim CurrentTicker As String
Dim YearlyOpen As Double
Dim YearlyClose As Double
Dim YearlyChange As Double
Dim PercentChange As Double
Dim StockValue As Double

For Each ws In Worksheets

ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 13).Value = "Ticker"
ws.Cells(1, 10).Value = "Yearly Change"
ws.Cells(1, 11).Value = "Percent Change"
ws.Cells(1, 12).Value = "Total Stock Value"
ws.Cells(2, 15).Value = "Greatest % Increase"
ws.Cells(3, 15).Value = "Greatest % Decrease"
ws.Cells(4, 15).Value = "Greatest Total Volume"
ws.Cells(1, 16).Value = "Ticker"
ws.Cells(1, 17).Value = "Value"
ws.Range("C:F").NumberFormat = "0.00"
ws.Range("G:G").NumberFormat = "0"
ws.Range("J:J").NumberFormat = "0.000000000"
ws.Range("K:K").NumberFormat = "0.00%"
ws.Range("L:L").NumberFormat = "0"
ws.Range("Q:Q").NumberFormat = "0.00%"
ws.Range("Q4").NumberFormat = "0"
LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
CurrentTicker = " "
StockValue = 0
    
    For i = 2 To LastRow
    
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                Ticker = ws.Cells(i, 1).Value
                YearlyClose = ws.Cells(i, 6).Value
                IRowCount = ws.Cells(Rows.Count, 9).End(xlUp).Row
                ws.Cells(IRowCount + 1, 9).Value = Ticker
                ws.Cells(IRowCount + 1, 13).Value = Ticker
                YearlyChange = YearlyClose - YearlyOpen
                ws.Cells(IRowCount + 1, 10).Value = YearlyChange
                StockValue = StockValue + ws.Cells(i, 7).Value
                ws.Cells(IRowCount + 1, 12).Value = StockValue
                
                If YearlyChange = 0 Then
                    ws.Cells(IRowCount + 1, 11).Value = "0"
                        
                Else:
                    PercentChange = (YearlyChange / YearlyClose)
                    ws.Cells(IRowCount + 1, 11).Value = PercentChange
                        
                        If PercentChange >= 0 Then
                            ws.Cells(IRowCount + 1, 11).Interior.ColorIndex = 4
                            
                        Else
                            ws.Cells(IRowCount + 1, 11).Interior.ColorIndex = 3
                            
                        End If
                    
                End If
            
        Else:
            
            If ws.Cells(i, 1).Value <> CurrentTicker Then
                YearlyOpen = ws.Cells(i, 3).Value
                CurrentTicker = ws.Cells(i, 1).Value
                
            Else
                StockValue = StockValue + ws.Cells(i, 7).Value
                
            End If
            
       End If
               
    Next i

ws.Range("M:M").Font.Color = RGB(255, 255, 255)
ws.Range("P2").Value = "=VLOOKUP(MAX(K:K), (K:M), 3, 0)"
ws.Range("Q2").Value = "=VLOOKUP(MAX(K:K), (K:M), 1, 0)"
ws.Range("P3").Value = "=VLOOKUP(MIN(K:K), (K:M), 3, 0)"
ws.Range("Q3").Value = "=VLOOKUP(MIN(K:K), (K:M), 1, 0)"
ws.Range("P4").Value = "=VLOOKUP(MAX(L:L), (L:M), 2, 0)"
ws.Range("Q4").Value = "=VLOOKUP(MAX(L:L), (L:M), 1, 0)"
ws.Range("A:Q").Columns.AutoFit

Next

End Sub

