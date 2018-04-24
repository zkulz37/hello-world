using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
using NativeExcel;

public partial class rpt_bimc00040_ST01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        


        string TemplateFile = "rpt_bimc00040_ST01.xls";
        string TempFile = "../../../system/temp/rpt_bimc00045_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        //Left header of order
        IRange range; 

		string p_wh_type 		= Request.QueryString["p_wh_type"];
		string p_wh_pk 			= Request.QueryString["p_wh_pk"];		
		string p_from_date 		= Request.QueryString["p_from_date"];
		string p_to_date 		= Request.QueryString["p_to_date"];
		string p_item_grp_pk	= Request.QueryString["p_item_grp_pk"];
		string p_item 			= Request.QueryString["p_item"];

		string para = "'" + p_wh_type + "','" + p_wh_pk + "','" + p_from_date + "','" + p_to_date + "','" + p_item_grp_pk + "','" + p_item + "'";
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_bimc00040_ST01_3", para);
		
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_bimc00040_ST01_1", "'" + Session["User_ID"].ToString() + "'");	
		
		para = "'" + p_wh_type + "','" + p_wh_pk + "','" + p_from_date + "','" + p_to_date + "','" + p_item_grp_pk + "','" + p_item + "'";
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_bimc00040_ST01_2", para);	
				
		if ( dtInfo.Rows.Count >0)	
        {
			exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"].ToString();
			exSheet.Cells["G1"].Value = "Tel :"+dtInfo.Rows[0]["phone_no"].ToString();
			exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"].ToString();
			exSheet.Cells["G2"].Value = "Fax :"+dtInfo.Rows[0]["fax_no"].ToString();
			exSheet.Cells["C3"].Value = "Tax code :"+dtInfo.Rows[0]["tax_code"].ToString();
			exSheet.Cells["G3"].Value = "Print Time :"+DateTime.Now.ToString("dd/MM/yyyy HH:mm"); 			
		}
		
		if ( dtMaster.Rows.Count >0)	
        {
			exSheet.Cells["C5"].Value = dtMaster.Rows[0]["wh_name"];
			
			exSheet.Cells["F6"].Value = dtMaster.Rows[0]["month_00"];
			exSheet.Cells["N6"].Value = dtMaster.Rows[0]["month_01"];
			exSheet.Cells["V6"].Value = dtMaster.Rows[0]["month_02"];
			exSheet.Cells["AD6"].Value = dtMaster.Rows[0]["month_03"];
			exSheet.Cells["AL6"].Value = dtMaster.Rows[0]["month_04"];
			exSheet.Cells["AT6"].Value = dtMaster.Rows[0]["month_05"];
			exSheet.Cells["BB6"].Value = dtMaster.Rows[0]["month_06"];
			exSheet.Cells["BJ6"].Value = dtMaster.Rows[0]["month_07"];
			exSheet.Cells["BR6"].Value = dtMaster.Rows[0]["month_08"];
			exSheet.Cells["BZ6"].Value = dtMaster.Rows[0]["month_09"];
			exSheet.Cells["CH6"].Value = dtMaster.Rows[0]["month_10"];
			exSheet.Cells["CP6"].Value = dtMaster.Rows[0]["month_11"];	
		}
		
		int l_pos = 9 ;
		
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A10"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
        for (int i = 0; i < dtDetail.Rows.Count; i++)
        {            		
			exSheet.Cells[l_pos + i, 1].Value = i+1;
			exSheet.Cells[l_pos + i, 2].Value = dtDetail.Rows[i]["item_code"];
			exSheet.Cells[l_pos + i, 3].Value = dtDetail.Rows[i]["item_name"];
			exSheet.Cells[l_pos + i, 4].Value = dtDetail.Rows[i]["uom"];
			exSheet.Cells[l_pos + i, 5].Value = dtDetail.Rows[i]["lot_no"];

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m00_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m00_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m00_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m00_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m00_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m00_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m00_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m00_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m01_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m01_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m01_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m01_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m01_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m01_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m01_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m01_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m02_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m02_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m02_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m02_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m02_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m02_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m02_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m02_end_amount"];	
			
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m03_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m03_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m03_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m03_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m03_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m03_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m03_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m03_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m04_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m04_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m04_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m04_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m04_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m04_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m04_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m04_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m05_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m05_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m05_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m05_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m05_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m05_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m05_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m05_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m06_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m06_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m06_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m06_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m06_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m06_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m06_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m06_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m07_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m07_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m07_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m07_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m07_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m07_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m07_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m07_end_amount"];		

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m08_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m08_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m08_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m08_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m08_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m08_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m08_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m08_end_amount"];
			
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m09_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m09_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m09_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m09_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m09_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m09_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m09_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m09_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m10_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m10_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m10_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m10_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m10_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m10_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m10_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m10_end_amount"];	

			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m11_begin_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m11_begin_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m11_in_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m11_in_amount"];	
			exSheet.Cells[l_pos + i, 6].Value = dtDetail.Rows[i]["m11_out_qty"];
			exSheet.Cells[l_pos + i, 7].Value = dtDetail.Rows[i]["m11_out_amount"];
			exSheet.Cells[l_pos + i, 8].Value = dtDetail.Rows[i]["m11_end_qty"];
			exSheet.Cells[l_pos + i, 9].Value = dtDetail.Rows[i]["m11_end_amount"];				
        }
		
		//--set-----DataBind--in---Master---
        if (!string.IsNullOrEmpty(dt.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dt.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 100, 55));
        }
		
		
        for (int l_addrow = 0; l_addrow < dt1.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        double to6 = 0,to7 = 0, to8 = 0, to9 = 0, to10 = 0, to11 = 0;
        for (int i = 0; i < dt1.Rows.Count; i++)
        {
            exSheet.Cells[7 + i, 1].Value = i+1;
            exSheet.Cells[7 + i, 2].Value = dt1.Rows[i]["item_code"];
            exSheet.Cells[7 + i, 3].Value = dt1.Rows[i]["item_name"];
            exSheet.Cells[7 + i, 4].Value = dt1.Rows[i]["uom"];
            exSheet.Cells[7 + i, 5].Value = dt1.Rows[i]["lot_no"];
			if(dt1.Rows[i]["begin_qty"].ToString() !="")
			{
				exSheet.Cells[7 + i, 6].Value = double.Parse(dt1.Rows[i]["begin_qty"].ToString());
				to6 = to6 + CommondLib.ConvertToDbl(dt1.Rows[i]["begin_qty"]);
			}
			if(dt1.Rows[i]["in_qty"].ToString() !="")
			{
				exSheet.Cells[7 + i, 7].Value = double.Parse(dt1.Rows[i]["in_qty"].ToString());
				to7 = to7 + CommondLib.ConvertToDbl(dt1.Rows[i]["in_qty"]);
			}
			if(dt1.Rows[i]["or_in_qty"].ToString() !="")
			{
				exSheet.Cells[7 + i, 8].Value = double.Parse(dt1.Rows[i]["or_in_qty"].ToString());
				to8 = to8 + CommondLib.ConvertToDbl(dt1.Rows[i]["or_in_qty"]);
			}
			if(dt1.Rows[i]["out_qty"].ToString() !="")
			{
				exSheet.Cells[7 + i, 9].Value = double.Parse(dt1.Rows[i]["out_qty"].ToString());
				to9 = to9 + CommondLib.ConvertToDbl(dt1.Rows[i]["out_qty"]);
			}
			if(dt1.Rows[i]["or_out_qty"].ToString() !="")
			{
				exSheet.Cells[7 + i, 10].Value = double.Parse(dt1.Rows[i]["or_out_qty"].ToString());
				to10 = to10 + CommondLib.ConvertToDbl(dt1.Rows[i]["or_out_qty"]);
			}
            if(dt1.Rows[i]["end_qty"].ToString() !="")
			{
				exSheet.Cells[7 + i, 11].Value = double.Parse(dt1.Rows[i]["end_qty"].ToString());
				to11 = to11 + CommondLib.ConvertToDbl(dt1.Rows[i]["end_qty"]);
			}
        }

        exSheet.Cells[8 + dt1.Rows.Count - 1, 6].Value = to6;
        exSheet.Cells[8 + dt1.Rows.Count - 1, 7].Value = to7;
        exSheet.Cells[8 + dt1.Rows.Count - 1, 8].Value = to8;
        exSheet.Cells[8 + dt1.Rows.Count - 1, 9].Value = to9;
        exSheet.Cells[8 + dt1.Rows.Count - 1, 10].Value = to10;
        exSheet.Cells[8 + dt1.Rows.Count - 1, 11].Value = to11;

        //range = exSheet.Range["A6"];
        //range.Rows.Hidden = true;
        range = exSheet.Range["A1"];
        //range.Rows.Hidden = true;

        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        exBook.SaveAs(TempFile);
        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Send file string to client 
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
