using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_mbo_eva_checking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
	    string TemplateFile = "rpt_mbo_eva_checking.xls";
        string TempFile = "../../../system/temp/rpt_mbo_eva_checking_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	   
	    //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
		IPageBreaks pbs = exBook.Worksheets[1].HPageBreaks;
        IRange usedrange = exBook.Worksheets[1].UsedRange;
	   
		string p_1,p_2,p_3,p_4,p_5,p_6,p_7,p_8,p_9,p_10;	
		 
		p_1 = Request["p_1"].ToString();
		p_2 = Request["p_2"].ToString();
		p_3 = Request["p_3"].ToString();
		p_4 = Request["p_4"].ToString();
		p_5 = Request["p_5"].ToString();
		p_6 = Request["p_6"].ToString();
		p_7 = Request["p_7"].ToString();
		p_8 = Request["p_8"].ToString();
		p_9 = Request["p_9"].ToString();
		p_10 = Request["p_10"].ToString();
		int irow_emp,icol_emp;
	
		string para = "'" + p_1 + "','" + p_2 + "','" + p_3 + "','" + p_4 + "','" + p_5 +"','" + p_6 +"','" + p_7 +"','" + p_8 + "','" + p_9 +  "'";
        //DataTable dt_emp = ESysLib.TableReadOpenCursor("sp_rpt_daily_emp_status_dorco", para);
		
		//Response.Write(para);
//Response.End();
		
		DataTable dt_emp = ESysLib.TableReadOpenCursor("HR_RPT_CHEM00290_V2_01", para);
		
		irow_emp = dt_emp.Rows.Count;
		icol_emp=dt_emp.Columns.Count;
		int spos = 6;
		int Flag = 0;
		int stt=0;
		int breakpage = 1;
		int rowstart = spos;
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
		
		exSheet.Cells["C2"].Value = Session["User_ID"].ToString();
        exSheet.Cells["C3"].Value = DateTime.Today.ToString("dd/MM/yyyy");
		exSheet.Cells["C4"].Value = p_10;
		for (int i = 1; i < irow_emp; i++)
        {
            exSheet.Range[spos + i, 1].Rows.EntireRow.Insert();
        }
			
        for (int i = 0; i < irow_emp; i++)
        {					
            for (int j = 0; j < icol_emp; j++)
            {		         		
				if (j>13)
				{
					if(dt_emp.Rows[i][j].ToString()=="")
						continue;
					exSheet.Cells[spos+i, j +1].Value = double.Parse(dt_emp.Rows[i][j].ToString());		
				}
				else
				{
					exSheet.Cells[spos+i, j +1].Value = dt_emp.Rows[i][j].ToString();			
				}
            }
			//sum
           /* if ((i < irow_emp - 1 && dt_emp.Rows[i]["EMP_ID"].ToString() != dt_emp.Rows[i + 1]["EMP_ID"].ToString()) || i == irow_emp - 1)
            {
                Flag = Flag + 1;
				stt= stt+1;
				//merg row
                exSheet.Range[spos + i + Flag, 1].Rows.EntireRow.Insert();
				exSheet.Range["B" + (spos + i + Flag) + ":N" + (spos + i + Flag)].Merge();
				exSheet.Range["B" + (spos + i + Flag) + ":S" + (spos + i + Flag)].Interior.Color = Color.FromArgb(217, 217, 217);
                exSheet.Range["B" + (spos + i + Flag) + ":S" + (spos + i + Flag)].Font.Bold = true;
				exSheet.Range["B" + (spos + i + Flag) + ":S" + (spos + i + Flag)].HorizontalAlignment = XlHAlign.xlHAlignRight;
                exSheet.Range["B" + (spos + i + Flag) + ":N" + (spos + i + Flag)].Value = "Total";
				
                for ( int j = 14; j < icol_emp; j++)
                {
					if (j==14||j==15||j==16||j==17||j==18)
					{
                    object temp = dt_emp.Compute("SUM(" + dt_emp.Columns[j].ColumnName + ")", "EMP_ID=" + dt_emp.Rows[i]["EMP_ID"].ToString());
                    exSheet.Cells[spos + i + Flag, j+1].Value = temp;
					}
                }
				//merg
				exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag)].Merge();
				exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["A" + rowstart].Value = stt;
				
				//exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag-1)].Merge();
				//exSheet.Range["A" + rowstart].Value = stt;
				
				exSheet.Range["B" + rowstart + ":B" + (spos + i + Flag-1)].Merge();
				exSheet.Range["B" + rowstart + ":B" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["B" + rowstart + ":B" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["B" + rowstart].Value = dt_emp.Rows[i]["ORG_NM"].ToString();
				
				exSheet.Range["C" + rowstart + ":C" + (spos + i + Flag-1)].Merge();
				exSheet.Range["C" + rowstart + ":C" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["C" + rowstart + ":C" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["C" + rowstart].Value = dt_emp.Rows[i]["GROUP_NM"].ToString();
					
				exSheet.Range["D" + rowstart + ":D" + (spos + i + Flag-1)].Merge();
				exSheet.Range["D" + rowstart + ":D" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["D" + rowstart + ":D" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["D" + rowstart].Value = dt_emp.Rows[i]["EMP_ID"].ToString();
					
				exSheet.Range["E" + rowstart + ":E" + (spos + i + Flag-1)].Merge();
				exSheet.Range["E" + rowstart + ":E" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["E" + rowstart + ":E" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["E" + rowstart].Value = dt_emp.Rows[i]["FULL_NAME"].ToString();
				
				exSheet.Range["F" + rowstart + ":F" + (spos + i + Flag-1)].Merge();
				exSheet.Range["F" + rowstart + ":F" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["F" + rowstart + ":F" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["F" + rowstart].Value = dt_emp.Rows[i]["M1_NM"].ToString();
					
				exSheet.Range["G" + rowstart + ":G" + (spos + i + Flag-1)].Merge();
			//	exSheet.Range["G" + rowstart + ":G" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["G" + rowstart + ":G" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["G" + rowstart].Value = dt_emp.Rows[i]["M2_NM"].ToString();
					
				exSheet.Range["H" + rowstart + ":H" + (spos + i + Flag-1)].Merge();
				exSheet.Range["H" + rowstart + ":H" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["H" + rowstart + ":H" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["H" + rowstart].Value = dt_emp.Rows[i]["MBO_STATUS"].ToString();
				
				exSheet.Range["I" + rowstart + ":I" + (spos + i + Flag-1)].Merge();
				exSheet.Range["I" + rowstart + ":I" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["I" + rowstart + ":I" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["I" + rowstart].Value = dt_emp.Rows[i]["MBO_CLOSE_YN"].ToString();
					
				exSheet.Range["J" + rowstart + ":J" + (spos + i + Flag-1)].Merge();
				exSheet.Range["J" + rowstart + ":J" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["J" + rowstart + ":J" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["J" + rowstart].Value = dt_emp.Rows[i]["EMP_EVA_STATUS"].ToString();
				
				exSheet.Range["K" + rowstart + ":K" + (spos + i + Flag-1)].Merge();
				exSheet.Range["K" + rowstart + ":K" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["K" + rowstart + ":K" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["k" + rowstart].Value = dt_emp.Rows[i]["DATA_CLOSE_YN"].ToString();
				
				//exSheet.Range["L" + rowstart].Value = dt_emp.Rows[i]["MBO_RESULT"].ToString();
				
				//exSheet.Range["M" + rowstart].Value = dt_emp.Rows[i]["TARGET_1"].ToString();
				
				//exSheet.Range["N" + rowstart].Value = dt_emp.Rows[i]["TARGET_2"].ToString();
				
				rowstart = spos + i + Flag + 1;
				 if(stt==10*breakpage)
				 {
					pbs.Add(usedrange.Rows[i+ 7]);
					breakpage= breakpage+1;
				 }
            }*/
        }
		
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;
        
        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");

        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
    
  
}