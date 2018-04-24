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

public partial class rpt_60250010_birthday : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());        

        string TemplateFile = "rpt_60250010_birthday.xls";
        string TempFile = "../../../system/temp/rpt_60250010_birthday_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		string p_pk = Request.QueryString["p_pk"];
		string p_dtfrom = Request.QueryString["p_dtfrom"];
		string p_dtto = Request.QueryString["p_dtto"];		
        string para= "'" + p_pk + "','" + p_dtfrom + "','" + p_dtto + "'";
		
		

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("ht_rpt_60250010_info", "'" + Session["User_ID"].ToString() + "'");
		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("hr_sel_10010023_announce_data", para);	
        ////end-set-----DataBind--in---Master---
		if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 100, 55));
        }
		exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"].ToString();

        exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"].ToString();

        exSheet.Cells["C3"].Value = "Tax code: " + dtInfo.Rows[0]["tax_code"].ToString();
		
		
        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        //set data to detail.
        // loop detail not percent
		int l_pos = 6;
		int i = 0 ;
		
        for (i = 0; i < dtDetail.Rows.Count; i++)
        {
            exSheet.Cells[4,1].Value = "Birthday :"+dtDetail.Rows[0]["dtfrom"].ToString()+" ~ "+dtDetail.Rows[0]["dtto"].ToString();
			exSheet.Cells[4,7].Value = "Print time :"+dtDetail.Rows[0]["print_time"].ToString();
			
			exSheet.Cells[l_pos+i,1].Value =i+1;
			exSheet.Cells[l_pos+i,2].Value = dtDetail.Rows[i]["room_no"].ToString(); 
			exSheet.Cells[l_pos+i,3].Value = dtDetail.Rows[i]["full_name"].ToString(); 
			exSheet.Cells[l_pos+i,4].Value = dtDetail.Rows[i]["gender"].ToString();
			exSheet.Cells[l_pos+i,5].Value = dtDetail.Rows[i]["nation"];
			exSheet.Cells[l_pos+i,6].Value = dtDetail.Rows[i]["checkin_date"].ToString(); 
			exSheet.Cells[l_pos+i,7].Value = dtDetail.Rows[i]["departure_date"].ToString(); 
			exSheet.Cells[l_pos+i,8].Value = dtDetail.Rows[i]["birthday"].ToString();
		}	
		//exSheet.Cells[dtDetail.Rows.Count + 6, 36].Value = "=SUM(AJ5:AJ" + (dtDetail.Rows.Count + 5) + ")";
        
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