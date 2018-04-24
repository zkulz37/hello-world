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

public partial class reports_rpt_fpma00101 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("sale");

        string TemplateFile = "rpt_fpma00101.xls";
        string TempFile = "../../../system/temp/rpt_fpma00101_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string p_asset_pk = Request.QueryString["p_asset_pk"];         

        string para = "'" + p_asset_pk + "'";
        DataTable dtHeader = ESysLib.TableReadOpenCursor("lg_rpt_fpma00101");
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_fpma00101_1", para);
        //DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_sel_fpma00330_1", para);

        // HEADER        
        exSheet.Cells["B1"].Value = dtHeader.Rows[0]["partner_name"];
        exSheet.Cells["B2"].Value = dtHeader.Rows[0]["addr1"];
		
		// MASTER        
        exSheet.Cells["D5"].Value = dtMaster.Rows[0]["asset_code"];       

        // END MASTER
        /*if (dtDetail.Rows.Count > 0)
        {
            for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
            {
                exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
            }

            // DETAIL
            int pos = 7;
            
            // end add header
            for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
            {
                exSheet.Cells[pos + l_row, 1].Value = l_row + 1;
                exSheet.Cells[pos + l_row, 2].Value = dtDetail.Rows[l_row]["asset_name"];
                exSheet.Cells[pos + l_row, 3].Value = dtDetail.Rows[l_row]["asset_model"];
                exSheet.Cells[pos + l_row, 4].Value = dtDetail.Rows[l_row]["dept_01"];
                exSheet.Cells[pos + l_row, 5].Value = dtDetail.Rows[l_row]["dept_02"];
                exSheet.Cells[pos + l_row, 6].Value = dtDetail.Rows[l_row]["dept_03"];
                exSheet.Cells[pos + l_row, 7].Value = dtDetail.Rows[l_row]["dept_04"];
                exSheet.Cells[pos + l_row, 8].Value = dtDetail.Rows[l_row]["dept_05"];

                exSheet.Cells[pos + l_row, 9].Value = dtDetail.Rows[l_row]["dept_06"];
                exSheet.Cells[pos + l_row, 10].Value = dtDetail.Rows[l_row]["dept_07"];
                exSheet.Cells[pos + l_row, 11].Value = dtDetail.Rows[l_row]["dept_08"];
                exSheet.Cells[pos + l_row, 12].Value = dtDetail.Rows[l_row]["dept_09"];
                exSheet.Cells[pos + l_row, 13].Value = dtDetail.Rows[l_row]["dept_10"];

                exSheet.Cells[pos + l_row, 14].Value = dtDetail.Rows[l_row]["dept_11"];
                exSheet.Cells[pos + l_row, 15].Value = dtDetail.Rows[l_row]["dept_12"];
                exSheet.Cells[pos + l_row, 16].Value = dtDetail.Rows[l_row]["dept_13"];
                exSheet.Cells[pos + l_row, 17].Value = dtDetail.Rows[l_row]["dept_14"];
                exSheet.Cells[pos + l_row, 18].Value = dtDetail.Rows[l_row]["dept_15"];

                exSheet.Cells[pos + l_row, 19].Value = dtDetail.Rows[l_row]["dept_16"];
                exSheet.Cells[pos + l_row, 20].Value = dtDetail.Rows[l_row]["dept_17"];
                exSheet.Cells[pos + l_row, 21].Value = dtDetail.Rows[l_row]["dept_18"];
                exSheet.Cells[pos + l_row, 22].Value = dtDetail.Rows[l_row]["dept_19"];
                exSheet.Cells[pos + l_row, 23].Value = dtDetail.Rows[l_row]["dept_20"];

                exSheet.Cells[pos + l_row, 24].Value = dtDetail.Rows[l_row]["dept_21"];
                exSheet.Cells[pos + l_row, 25].Value = dtDetail.Rows[l_row]["dept_22"];
                exSheet.Cells[pos + l_row, 26].Value = dtDetail.Rows[l_row]["dept_23"];
                exSheet.Cells[pos + l_row, 27].Value = dtDetail.Rows[l_row]["dept_24"];
                exSheet.Cells[pos + l_row, 28].Value = dtDetail.Rows[l_row]["dept_25"];

                exSheet.Cells[pos + l_row, 29].Value = "=SUM(D" + (7 + l_row) + ":AB" + (7 + l_row) + ")";
            }
            int count = 3;
            for (int a = 68; a <= 90; a++) // A-Z
            {
                count++;
                exSheet.Cells[dtDetail.Rows.Count + 7, count].Value = "=SUM(" + Convert.ToChar(a) + "7:" + Convert.ToChar(a) + (dtDetail.Rows.Count + 6) + ")";
            }
            exSheet.Cells[dtDetail.Rows.Count + 7, count + 1].Value = "=SUM(AA7:AA" + (dtDetail.Rows.Count + 6) + ")";
            exSheet.Cells[dtDetail.Rows.Count + 7, count + 2].Value = "=SUM(AB7:AB" + (dtDetail.Rows.Count + 6) + ")";
            exSheet.Cells[dtDetail.Rows.Count + 7, count + 3].Value = "=SUM(AC7:AC" + (dtDetail.Rows.Count + 6) + ")";
            // END DETAIL
        }
*/
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }       
 

        exBook.SaveAs(TempFile);
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