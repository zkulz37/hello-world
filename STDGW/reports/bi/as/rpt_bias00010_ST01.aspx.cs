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

public partial class rpt_bias00010_ST01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("baguette");
		
        string l_po_pk = Request["master_pk"];
        string l_wh_pk = Request["wh_pk"];
        
        string TemplateFile = "rpt_bias00010_ST01.xls";
        string TempFile = "../../../system/temp/rpt_bias00010_ST01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        DataTable dtInfo = ESysLib.TableReadOpenCursor("lg_rpt_bias00010_ST01", "'" + Session["User_ID"].ToString() + "'");

        //--set-----DataBind--in---Info---
        if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 131, 71));
        }
        exSheet.Cells[1, 3].Value = dtInfo.Rows[0]["partner_name"].ToString();

        exSheet.Cells[1, 6].Value = "Tel: " + dtInfo.Rows[0]["phone_no"].ToString();

        exSheet.Cells[2, 3].Value = "Addr: " + dtInfo.Rows[0]["addr1"].ToString();

        exSheet.Cells[2, 6].Value = "Fax: " + dtInfo.Rows[0]["fax_no"].ToString();

        exSheet.Cells[3, 3].Value = "MST: " + dtInfo.Rows[0]["tax_code"].ToString();

        exSheet.Cells[3, 6].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy");  //dtInfo.Rows[0]["issue_dt"].ToString();

        ////end-set-----DataBind--in---Info---
        double total_sub = 0, total_vat = 0, total_amt = 0, total_req = 0, total_qty = 0;
        int temp_row = 5, vt_sub = 0;

        // title
        int SEQ = 1,
            REF_NO = 2,
            ITEM_CD = 3,
            ITEM_NM = 4,
            UOM = 5,
            IN_QTY = 6,
            PRICE = 7,
            TOTAL_AMT = 8,
            REMARK = 9;

        DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_bias00010_ST01_1", "'" + l_po_pk + "'");
        DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_bias00010_ST01_2", "'" + l_po_pk + "'");
        if (dt2.Rows.Count == 0)
        {
            return;
        }
        
                temp_row = 10;
                total_sub = 0; total_vat = 0; total_amt = 0; total_req = 0; total_qty = 0;
                for (int l_addrow = 1; l_addrow < dt2.Rows.Count ; l_addrow++)
                {
                    exSheet.Range["A11" ].Rows.EntireRow.Insert();//insert row new of sheet
                }
                exSheet.Cells[5, 3].Value = dt1.Rows[0]["out_name"].ToString();
                exSheet.Cells[5, 9].Value = dt1.Rows[0]["slip_no"].ToString();

                exSheet.Cells[6, 3].Value = dt1.Rows[0]["in_name"].ToString();    //income_no               
                exSheet.Cells[6, 9].Value = dt1.Rows[0]["tr_date"].ToString();

                exSheet.Cells[7, 3].Value = dt1.Rows[0]["description"].ToString();
                exSheet.Cells[7, 9].Value = dt1.Rows[0]["ref_no"].ToString();
               
                for (int l_row = 0; l_row < dt2.Rows.Count; l_row++)
                {
                    //exSheet.Range[10, 1, 10, 12].Copy(exSheet.Range[temp_row, 1, temp_row, 12], XlPasteType.xlPasteAll);
                   // exSheet.Cells.Rows[temp_row].RowHeight = 30;

                    exSheet.Cells[temp_row, SEQ].Value = l_row + 1;// seq
                    exSheet.Cells[temp_row, REF_NO].Value = dt2.Rows[l_row]["ref_no"].ToString();// ref
                    exSheet.Cells[temp_row, ITEM_CD].Value = dt2.Rows[l_row]["item_code"].ToString();// item_cd
                    exSheet.Cells[temp_row, ITEM_NM].Value = dt2.Rows[l_row]["item_name"].ToString();// item_nm
                    exSheet.Cells[temp_row, UOM].Value = dt2.Rows[l_row]["req_uom"].ToString();// uom
                    exSheet.Cells[temp_row, IN_QTY].Value = Convert.ToDouble(dt2.Rows[l_row]["tr_qty"]);// in_qty
                    exSheet.Cells[temp_row, PRICE].Value = Convert.ToDouble(dt2.Rows[l_row]["unit_price"]);// unit price
                    exSheet.Cells[temp_row, TOTAL_AMT].Value = Convert.ToDouble(dt2.Rows[l_row]["total_amount"]);// total amount
                    exSheet.Cells[temp_row, REMARK].Value = dt2.Rows[l_row]["description"].ToString();// remark

                    total_qty += Convert.ToDouble(dt2.Rows[l_row]["tr_qty"]);
                    total_amt += Convert.ToDouble(dt2.Rows[l_row]["total_amount"]);
                    temp_row = temp_row + 1;
                }
                /*exSheet.Cells[dt2.Rows.Count + 10, 6].Value = "=SUM(F3:F" + (l_row + pos - 1) + ")"; 
                exSheet.Cells[dt2.Rows.Count + 11, 6].Value = Convert.ToDouble(dt1.Rows[0]["vat_amount"]);
                exSheet.Cells[dt2.Rows.Count + 12, 6].Value = Convert.ToDouble(dt1.Rows[0]["total_amount"]);
                */
                //exSheet.Range[vt_sub, 1, vt_sub, 12].Copy(exSheet.Range[temp_row, 1, temp_row, 12], XlPasteType.xlPasteAll);
                //exSheet.Cells.Rows[temp_row].RowHeight = 30;

                exSheet.Cells[temp_row, IN_QTY].Value = total_qty;
                exSheet.Cells[temp_row, TOTAL_AMT].Value = total_amt;

        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        // hide row firts 
        range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;
        range.Value = string.Empty;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

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
