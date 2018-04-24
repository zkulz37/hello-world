using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class reports_rpt_fpfa00341 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string l_pk = Request["master_pk"];

        string TemplateFile = "rpt_fpfa00341.xls";
        string TempFile = "../../../system/temp/rpt_fpfa00341_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        string para = "'" + l_pk + "'";
        DataTable dtInfo = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00341", para);
        DataTable dtMaster = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00341_1", para);
        DataTable dtDetail = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00341_2", para);

        //--set-----DataBind--in---Info---
        exSheet.Cells[1, 11].Value = dtInfo.Rows[0]["department"].ToString();

        exSheet.Cells[1, 14].Value = dtInfo.Rows[0]["foreman"].ToString();

        exSheet.Cells[2, 11].Value = DateTime.Now.ToString("dd/MM/yyyy");  //dtInfo.Rows[0]["issue_dt"].ToString();

        exSheet.Cells[2, 14].Value = dtInfo.Rows[0]["w_period"].ToString();

        exSheet.Cells[3, 11].Value = dtInfo.Rows[0]["doc_no"].ToString();

        exSheet.Cells[3, 14].Value = dtInfo.Rows[0]["prepared"].ToString();

        ////end-set-----DataBind--in---Info---

        //--set-----DataBind--in---Master---
        exSheet.Cells[7, 1].Value = dtMaster.Rows[0]["proj_nm"].ToString();
        exSheet.Cells[7, 1, 7, 2].Merge();
        exSheet.Cells[7, 3].Value = Convert.ToDecimal(dtMaster.Rows[0]["proj_contract_weight"]);
        exSheet.Cells[7 , 3, 7, 4].Merge();
        exSheet.Cells[7, 5].Value = Convert.ToDecimal(dtMaster.Rows[0]["target_ord_qty"]);
        exSheet.Cells[7, 5, 7, 6].Merge();
        exSheet.Cells[7, 7].Value = "=G" + (dtDetail.Rows.Count + 10 + 7);

        exSheet.Cells[7, 8].Value = Convert.ToDecimal(dtMaster.Rows[0]["accumulation_fabrication"]);

        exSheet.Cells[7, 9].Value = "=H7/J7" ;

        exSheet.Cells[7, 10].Value = Convert.ToDecimal(dtMaster.Rows[0]["accumulation_manpower"]);

        exSheet.Cells[7, 11].Value = Convert.ToDecimal(dtMaster.Rows[0]["fabrication"]);

        exSheet.Cells[7, 12].Value = "=K7/M7";

        exSheet.Cells[7, 13].Value = Convert.ToInt32(dtMaster.Rows[0]["manpower"]);

        exSheet.Cells[7, 14].Value = Convert.ToInt32(dtMaster.Rows[0]["daily_man"]);
        ////end-set-----DataBind--in---Master---

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A10"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent

        for (int l_row = 1; l_row <= dtDetail.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 14; col++)
            {
                if (col == 0) // seq
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = l_row;
                }
                else if (col == 1) // dwgno
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["dwgno"].ToString();
                }
                else if (col == 2) // rev
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["rev"].ToString();
                    //exSheet.Cells[10 + l_row, 3, 10 + l_row, 5].Merge();
                }
                else if (col == 3) // name
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["name"].ToString();
                }
                else if (col == 4) // idmk
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["idmk"].ToString();
                }
                else if (col == 5) // qty
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = Convert.ToDouble(dtDetail.Rows[l_row - 1]["qty"]);
                }
                else if (col == 6) // unit
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = Convert.ToDouble(dtDetail.Rows[l_row - 1]["unit"]);
                }
                else if (col == 7) // total
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = "=F" + (10 + l_row) + "*G" + (10 + l_row);
                }
                else if (col == 8) // dwg_cp
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["dwg_cp"].ToString();
                }
                else if (col == 9) // material
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["material"].ToString();
                    
                }
                else if (col == 10) // deadline
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["deadline"].ToString();
                }
                else if (col == 11) // mar_cut
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["mar_cut"].ToString();
                }
                else if (col == 12) // fit_up
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["fit_up"].ToString();
                }
                else if (col == 13) // welding
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["welding"].ToString();
                }
                else if (col == 14) // inspection
                {
                    exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["inspection"].ToString();
                }
                /*   if (col == 0)
             {
                 exSheet.Cells[10 + l_row, col].Value = l_row; // no
             }
             else
             {
                 exSheet.Cells[10 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1]["item_code"].ToString();
             }
              
         else
         {
              exSheet.Cells[12 + l_row, col + 1].Value = long.Parse(dtDetail.Rows[l_row - 1][col].ToString());
              exSheet.Cells[13, col + 1, l_row + 13, col + 1].NumberFormat = "#,##0";
              exSheet.Cells[l_row + 12, col + 1].HorizontalAlignment = XlHAlign.xlHAlignRight;
              exSheet.Range[13, col + 1, l_row + 13, 6].Font.Bold = false;
         }

         exSheet.Cells[l_row + 12, 1].HorizontalAlignment = XlHAlign.xlHAlignCenter;
         exSheet.Cells[l_row + 13, 1].HorizontalAlignment = XlHAlign.xlHAlignCenter;
         exSheet.Cells[l_row + 13, 2].HorizontalAlignment = XlHAlign.xlHAlignCenter;
         exSheet.Cells[l_row + 13, 3].HorizontalAlignment = XlHAlign.xlHAlignLeft;
         exSheet.Cells[l_row + 13, 5].HorizontalAlignment = XlHAlign.xlHAlignLeft;
         exSheet.Cells[l_row + 13, 6].HorizontalAlignment = XlHAlign.xlHAlignLeft;*/
            }
        }
        exSheet.Cells[dtDetail.Rows.Count + 12, 6].Value = "=SUM(F11:F" + (dtDetail.Rows.Count + 10) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 12, 8].Value = "=SUM(H11:H" + (dtDetail.Rows.Count + 10) + ")";


        exSheet.Cells[dtDetail.Rows.Count + 17, 5].Value = "=B" + (dtDetail.Rows.Count + 17) + "/D" + (dtDetail.Rows.Count + 17);
        exSheet.Cells[dtDetail.Rows.Count + 17, 7].Value = "=C7/E" + (dtDetail.Rows.Count + 17);

        //exSheet.Cells[dtDetail.Rows.Count + 22, 13].Value = "=SUM(M21:M" + (dtDetail.Rows.Count + 10) + ")*10%";
        //exSheet.Cells[dtDetail.Rows.Count + 23, 13].Value = "=SUM(M21:M" + (dtDetail.Rows.Count + 10) + ")+ (SUM(M21:M" + (dtDetail.Rows.Count + 10) + ")*10%)";
        // end loop detail not percent

        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        range = exSheet.Range["A1"];
        // hide row A5 
        // range.Rows.Hidden = true;

        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
        ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }

    public Bitmap ResizeImage(Bitmap d, int w, int h)
    {
        Bitmap q = new Bitmap(w, h);
        float f, g;
        f = (float)w / (float)d.Width;
        g = (float)h / (float)d.Height;
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < h; j++)
            {
                Color c;
                c = d.GetPixel((int)(i / f), (int)(j / g));
                q.SetPixel(i, j, c);
            }
        }
        return q;
    }
}