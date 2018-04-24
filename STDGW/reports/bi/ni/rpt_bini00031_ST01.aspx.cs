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

public partial class rpt_bini00031_ST01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
        string l_po_pk = Request["p_income_pk"];


        string l_parameter = "'" + l_po_pk + "'";

        string TemplateFile = "rpt_bini00031_ST01.xls";
        string TempFile = "../../../system/temp/rpt_bini00031_ST01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        DataTable dtInfo = ESysLib.TableReadOpenCursor("lg_rpt_bini00031_ST01");

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

        exSheet.Cells[1, 7].Value = "Tel: " + dtInfo.Rows[0]["phone_no"].ToString();

        exSheet.Cells[2, 3].Value = "Addr: " + dtInfo.Rows[0]["addr1"].ToString();

        exSheet.Cells[2, 7].Value = "Fax: " + dtInfo.Rows[0]["fax_no"].ToString();

        exSheet.Cells[3, 3].Value = "MST: " + dtInfo.Rows[0]["tax_code"].ToString();

        exSheet.Cells[3, 7].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy");  //dtInfo.Rows[0]["issue_dt"].ToString();

        ////end-set-----DataBind--in---Info---

        string[] arrPK = l_po_pk.Split(',');
        double total_sub = 0, total_vat = 0, total_amt = 0, total_req = 0, total_qty = 0;
        int temp_row = 5, vt_sub = 0;

        // title
        int SEQ = 1,
            REF_NO = 2,
            ITEM_CD = 3,
            ITEM_NM = 4,
            UOM = 5,
            REQ_QTY = 6,
            IN_QTY = 7,
            PRICE = 8,
            AMT = 9,
            TAX = 10,
            TOTAL_AMT = 11,
            REMARK = 12;

        // end title
        for (int i = 0; i < arrPK.Length; i++)
        {
            DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_bini00031_ST01_1", "'" + arrPK[i] + "'");
            DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_bini00031_ST01_2", "'" + arrPK[i] + "'");
            if (i == 0)
            {
                exSheet.Cells[temp_row, 3].Value = dt1.Rows[0]["supplier_name"].ToString();
                exSheet.Cells[temp_row, 7].Value = dt1.Rows[0]["wh_name"].ToString();
                exSheet.Cells[temp_row, 12].Value = dt1.Rows[0]["slip_no"].ToString();
                temp_row = temp_row + 1;
                exSheet.Cells[temp_row, 3].Value = dt1.Rows[0]["description"].ToString();    //income_no               
                exSheet.Cells[temp_row, 7].Value = dt1.Rows[0]["ref_no"].ToString();
                exSheet.Cells[temp_row, 12].Value = dt1.Rows[0]["in_date"].ToString();
                temp_row = temp_row + 3;

                for (int l_addrow = 1; l_addrow < dt2.Rows.Count; l_addrow++)
                {
                    exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet
                }

                for (int l_row = 0; l_row < dt2.Rows.Count; l_row++)
                {

                    temp_row = temp_row + 1;
                    exSheet.Cells[temp_row, SEQ].Value = l_row + 1;// seq
                    exSheet.Cells[temp_row, REF_NO].Value = dt2.Rows[l_row]["ref_no"].ToString();// ref
                    exSheet.Cells[temp_row, ITEM_CD].Value = dt2.Rows[l_row]["item_code"].ToString();// item_cd
                    exSheet.Cells[temp_row, ITEM_NM].Value = dt2.Rows[l_row]["item_name"].ToString();// item_nm
                    exSheet.Cells[temp_row, UOM].Value = dt2.Rows[l_row]["in_uom"].ToString();// uom
                    exSheet.Cells[temp_row, REQ_QTY].Value = Convert.ToDouble(dt2.Rows[l_row]["req_qty"]);// req_qty
                    exSheet.Cells[temp_row, IN_QTY].Value = Convert.ToDouble(dt2.Rows[l_row]["in_qty"]);// in_qty
                    exSheet.Cells[temp_row, PRICE].Value = Convert.ToDouble(dt2.Rows[l_row]["unit_price"]);// unit price
                    exSheet.Cells[temp_row, AMT].Value = Convert.ToDouble(dt2.Rows[l_row]["item_amount"]);//  item_amount
                    exSheet.Cells[temp_row, TAX].Value = Convert.ToDouble(dt2.Rows[l_row]["vat_amount"]);// vat amount
                    exSheet.Cells[temp_row, TOTAL_AMT].Value = Convert.ToDouble(dt2.Rows[l_row]["total_amount"]);// total amount
                    exSheet.Cells[temp_row, REMARK].Value = dt2.Rows[l_row]["description"].ToString();// remark

                    total_req += Convert.ToDouble(dt2.Rows[l_row]["req_qty"]);
                    total_qty += Convert.ToDouble(dt2.Rows[l_row]["in_qty"]);
                    total_sub += Convert.ToDouble(dt2.Rows[l_row]["item_amount"]);
                    total_vat += Convert.ToDouble(dt2.Rows[l_row]["vat_amount"]);
                    total_amt += Convert.ToDouble(dt2.Rows[l_row]["total_amount"]);
                }
                /*exSheet.Cells[dt2.Rows.Count + 10, 6].Value = "=SUM(F3:F" + (l_row + pos - 1) + ")"; 
                exSheet.Cells[dt2.Rows.Count + 11, 6].Value = Convert.ToDouble(dt1.Rows[0]["vat_amount"]);
                exSheet.Cells[dt2.Rows.Count + 12, 6].Value = Convert.ToDouble(dt1.Rows[0]["total_amount"]);
                */
                temp_row = temp_row + 1;
                exSheet.Cells[temp_row, REQ_QTY].Value = total_req;
                exSheet.Cells[temp_row, IN_QTY].Value = total_qty;
                exSheet.Cells[temp_row, AMT].Value = total_sub;
                exSheet.Cells[temp_row, TAX].Value = total_vat;
                exSheet.Cells[temp_row, TOTAL_AMT].Value = total_amt;
                //count now rows
                vt_sub = temp_row;
                ///////////////////////////////////////////999999999999999999999999999//////////////////////
            }
            else
            {
                temp_row = temp_row + 2;
                total_sub = 0; total_vat = 0; total_amt = 0; total_req = 0; total_qty = 0;
                for (int l_addrow = 1; l_addrow < dt2.Rows.Count + 6; l_addrow++)
                {
                    exSheet.Range["A" + temp_row].Rows.EntireRow.Insert();//insert row new of sheet
                }
                temp_row = temp_row + 1;
                exSheet.Range[5, 1, 5, 12].Copy(exSheet.Range[temp_row, 1, temp_row, 12], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp_row].RowHeight = 22.5;
                exSheet.Cells[temp_row, 3].Value = dt1.Rows[0]["supplier_name"].ToString();
                exSheet.Cells[temp_row, 7].Value = dt1.Rows[0]["wh_name"].ToString();
                exSheet.Cells[temp_row, 12].Value = dt1.Rows[0]["slip_no"].ToString();

                temp_row = temp_row + 1;
                exSheet.Range[6, 1, 6, 12].Copy(exSheet.Range[temp_row, 1, temp_row, 12], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp_row].RowHeight = 22.5;
                exSheet.Cells[temp_row, 3].Value = dt1.Rows[0]["description"].ToString();    //income_no               
                exSheet.Cells[temp_row, 7].Value = dt1.Rows[0]["ref_no"].ToString();
                exSheet.Cells[temp_row, 12].Value = dt1.Rows[0]["in_date"].ToString();
                temp_row = temp_row + 1;

                exSheet.Range[8, 1, 9, 12].Copy(exSheet.Range[temp_row, 1, temp_row + 1, 12], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp_row].RowHeight = 18;
                exSheet.Cells.Rows[temp_row + 1].RowHeight = 26.25;

                temp_row = temp_row + 2;

                for (int l_row = 0; l_row < dt2.Rows.Count; l_row++)
                {
                    exSheet.Range[10, 1, 10, 12].Copy(exSheet.Range[temp_row, 1, temp_row, 12], XlPasteType.xlPasteAll);
                    exSheet.Cells.Rows[temp_row].RowHeight = 30;

                    exSheet.Cells[temp_row, SEQ].Value = l_row + 1;// seq
                    exSheet.Cells[temp_row, REF_NO].Value = dt2.Rows[l_row]["ref_no"].ToString();// ref
                    exSheet.Cells[temp_row, ITEM_CD].Value = dt2.Rows[l_row]["item_code"].ToString();// item_cd
                    exSheet.Cells[temp_row, ITEM_NM].Value = dt2.Rows[l_row]["item_name"].ToString();// item_nm
                    exSheet.Cells[temp_row, UOM].Value = dt2.Rows[l_row]["in_uom"].ToString();// uom
                    exSheet.Cells[temp_row, REQ_QTY].Value = Convert.ToDouble(dt2.Rows[l_row]["req_qty"]);// req_qty
                    exSheet.Cells[temp_row, IN_QTY].Value = Convert.ToDouble(dt2.Rows[l_row]["in_qty"]);// in_qty
                    exSheet.Cells[temp_row, PRICE].Value = Convert.ToDouble(dt2.Rows[l_row]["unit_price"]);// unit price
                    exSheet.Cells[temp_row, AMT].Value = Convert.ToDouble(dt2.Rows[l_row]["item_amount"]);//  item_amount
                    exSheet.Cells[temp_row, TAX].Value = Convert.ToDouble(dt2.Rows[l_row]["vat_amount"]);// vat amount
                    exSheet.Cells[temp_row, TOTAL_AMT].Value = Convert.ToDouble(dt2.Rows[l_row]["total_amount"]);// total amount
                    exSheet.Cells[temp_row, REMARK].Value = dt2.Rows[l_row]["description"].ToString();// remark

                    total_req += Convert.ToDouble(dt2.Rows[l_row]["req_qty"]);
                    total_qty += Convert.ToDouble(dt2.Rows[l_row]["in_qty"]);
                    total_sub += Convert.ToDouble(dt2.Rows[l_row]["item_amount"]);
                    total_vat += Convert.ToDouble(dt2.Rows[l_row]["vat_amount"]);
                    total_amt += Convert.ToDouble(dt2.Rows[l_row]["total_amount"]);
                    temp_row = temp_row + 1;
                }
                /*exSheet.Cells[dt2.Rows.Count + 10, 6].Value = "=SUM(F3:F" + (l_row + pos - 1) + ")"; 
                exSheet.Cells[dt2.Rows.Count + 11, 6].Value = Convert.ToDouble(dt1.Rows[0]["vat_amount"]);
                exSheet.Cells[dt2.Rows.Count + 12, 6].Value = Convert.ToDouble(dt1.Rows[0]["total_amount"]);
                */
                exSheet.Range[vt_sub, 1, vt_sub, 12].Copy(exSheet.Range[temp_row, 1, temp_row, 12], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp_row].RowHeight = 30;

                exSheet.Cells[temp_row, REQ_QTY].Value = total_req;
                exSheet.Cells[temp_row, IN_QTY].Value = total_qty;
                exSheet.Cells[temp_row, AMT].Value = total_sub;
                exSheet.Cells[temp_row, TAX].Value = total_vat;
                exSheet.Cells[temp_row, TOTAL_AMT].Value = total_amt;

                exSheet.Range[vt_sub + 1, 1, vt_sub + 1, 12].Copy(exSheet.Range[temp_row + 1, 1, temp_row + 1, 12], XlPasteType.xlPasteAll);
            }
        }

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
