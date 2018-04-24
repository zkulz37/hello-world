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

public partial class rpt_epbp00113 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("sale");
        string l_po_pk = Request["p_po_pk"];


        string l_parameter = "'" + l_po_pk + "'";

        string TemplateFile = "rpt_epbp00113.xls";
        string TempFile = "../../../system/temp/rpt_epbp00113_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        DataTable dtInfo = ESysLib.TableReadOpenCursor("lg_rpt_epbp00113");

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
        double total_sub = 0, total_vat = 0, total_amt = 0;
        int temp = 0,vt_sub= 0;

        // title
        int SEQ = 0,
            ITEM = 1,
            UOM = 3,
            QTY = 4,
            UNIT_PRICE = 5,
            PO_AMT = 6,
            REMARK = 7;
           
        // end title
        for (int i = 0; i < arrPK.Length; i++)
        {
            DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00113_1", "'" + arrPK[i] + "'");
            DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00113_2", "'" + arrPK[i] + "'");
            if (i == 0)
            {      
                exSheet.Cells[5, 3].Value = dt1.Rows[0]["partner_name"].ToString();
                exSheet.Cells[6, 3].Value = dt1.Rows[0]["po_no"].ToString();    //po_no
                exSheet.Cells[6, 6].Value = dt1.Rows[0]["po_date"].ToString();
                exSheet.Cells[7, 3].Value = dt1.Rows[0]["description"].ToString();
                for (int l_addrow = 1; l_addrow < dt2.Rows.Count; l_addrow++)
                {
                    exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet
                }

                for (int l_row = 1; l_row <= dt2.Rows.Count; l_row++)
                {
                    for (int col = SEQ; col <= REMARK; col++)
                    {
                        if (col == SEQ) // seq
                        {
                            exSheet.Cells[9 + l_row, col + 1].Value = l_row;
                        }
                        else if (col == ITEM) // item
                        {
                            exSheet.Cells[9 + l_row, col + 1].Value = dt2.Rows[l_row - 1]["po_item_name"].ToString() + "/" + dt2.Rows[l_row - 1]["po_item_name_3"].ToString();
                            exSheet.Cells[9 + l_row, 2, 9 + l_row, 3].Merge();
                        }
                        else if (col == UOM) // uom
                        {
                            exSheet.Cells[9 + l_row, col + 1].Value = dt2.Rows[l_row - 1]["po_uom_01"].ToString();

                        }
                        else if (col == QTY) //qty
                        {
                            exSheet.Cells[9 + l_row, col + 1].Value = Convert.ToDouble(dt2.Rows[l_row - 1]["po_qty_01"]);
                        }
                        else if (col == UNIT_PRICE) //unit_price 
                        {
                            exSheet.Cells[9 + l_row, col + 1].Value = Convert.ToDouble(dt2.Rows[l_row - 1]["unit_price"]);
                        }

                        else if (col == PO_AMT) //po_amt
                        {
                            exSheet.Cells[9 + l_row, col + 1].Value = Convert.ToDouble(dt2.Rows[l_row - 1]["po_amt"]);
                        }
                        else if (col == REMARK) //remarks
                        {
                            exSheet.Cells[9 + l_row, col + 1].Value = "";
                        }
                    }
                }
                exSheet.Cells[dt2.Rows.Count + 10, 6].Value = Convert.ToDouble(dt1.Rows[0]["po_amt"]);
                exSheet.Cells[dt2.Rows.Count + 11, 6].Value = Convert.ToDouble(dt1.Rows[0]["vat_amt"]);
                exSheet.Cells[dt2.Rows.Count + 12, 6].Value = Convert.ToDouble(dt1.Rows[0]["total_amt"]);
                total_sub += Convert.ToDouble(dt1.Rows[0]["po_amt"]);
                total_vat += Convert.ToDouble(dt1.Rows[0]["vat_amt"]);
                total_amt += Convert.ToDouble(dt1.Rows[0]["total_amt"]);
                //count now rows
                temp += 14 + dt2.Rows.Count;
                vt_sub = 10 + dt2.Rows.Count;
            }
            else
            {
                for (int l_addrow = 1; l_addrow < dt2.Rows.Count + 10; l_addrow++)
                {
                    exSheet.Range["A" + temp].Rows.EntireRow.Insert();//insert row new of sheet
                }
                exSheet.Range[5, 1, 5, 8].Copy(exSheet.Range[temp, 1, temp, 8], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp].RowHeight = 22.5;  
                exSheet.Cells[temp, 3].Value = dt1.Rows[0]["partner_name"].ToString();
               

                exSheet.Range[6, 1, 6, 8].Copy(exSheet.Range[temp + 1, 1, temp + 1, 8], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp + 1].RowHeight = 22.5;   
                exSheet.Cells[temp + 1, 3].Value = dt1.Rows[0]["po_no"].ToString();    //po_no        
                exSheet.Cells[temp + 1, 6].Value = dt1.Rows[0]["po_date"].ToString();

                exSheet.Range[7, 1, 7, 8].Copy(exSheet.Range[temp + 2, 1, temp + 2, 8], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp + 2].RowHeight = 22.5;
                exSheet.Cells[temp + 2, 3].Value = dt1.Rows[0]["description"].ToString();

                exSheet.Range[9, 1, 9, 8].Copy(exSheet.Range[temp + 4, 1, temp + 4, 8], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[temp + 4].RowHeight = 30;

                for (int l_row = 1; l_row <= dt2.Rows.Count; l_row++)
                {
                    exSheet.Range[10, 1, 10, 8].Copy(exSheet.Range[temp + 4 + l_row, 1, temp + 4 + l_row, 8], XlPasteType.xlPasteAll);
                    exSheet.Cells.Rows[temp + 4 + l_row].RowHeight = 37.5;
                    for (int col = SEQ; col <= REMARK; col++)
                    {
                        if (col == SEQ) // seq
                        {
                            exSheet.Cells[temp + 4 + l_row, col + 1].Value = l_row;
                        }
                        else if (col == ITEM) // item
                        {
                            //exSheet.Cells[temp + 4 + l_row, col + 1].Font.Italic = true;
                            exSheet.Cells[temp + 4 + l_row, col + 1].Value = dt2.Rows[l_row - 1]["po_item_name"].ToString() + "/" + dt2.Rows[l_row - 1]["po_item_name_3"].ToString();// +"\n" + dt2.Rows[l_row - 1]["po_item_name_3"].ToString();
                            exSheet.Cells[temp + 4 + l_row, 2, temp + 4 + l_row, 3].Merge();
                        }
                        else if (col == UOM) // uom
                        {
                            exSheet.Cells[temp + 4 + l_row, col + 1].Value = dt2.Rows[l_row - 1]["po_uom_01"].ToString();

                        }
                        else if (col == QTY) //qty
                        {
                            exSheet.Cells[temp + 4 + l_row, col + 1].Value = Convert.ToDouble(dt2.Rows[l_row - 1]["po_qty_01"]);
                        }
                        else if (col == UNIT_PRICE) //unit_price 
                        {
                            exSheet.Cells[temp + 4 + l_row, col + 1].Value = Convert.ToDouble(dt2.Rows[l_row - 1]["unit_price"]);
                        }

                        else if (col == PO_AMT) //po_amt
                        {
                            exSheet.Cells[temp + 4 + l_row, col + 1].Value = Convert.ToDouble(dt2.Rows[l_row - 1]["po_amt"]);
                        }
                        else if (col == REMARK) //remarks
                        {
                            exSheet.Cells[temp + 4 + l_row, col + 1].Value = "";
                        }
                    }
                }
                //sub_amt
                exSheet.Range[vt_sub, 1, vt_sub, 8].Copy(exSheet.Range[dt2.Rows.Count + temp + 5, 1, dt2.Rows.Count + temp + 5, 8], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[dt2.Rows.Count + temp + 5].RowHeight = 25;  
                exSheet.Cells[dt2.Rows.Count + temp + 5, 6].Value = Convert.ToDouble(dt1.Rows[0]["po_amt"]);   
                //vat_amt
                exSheet.Range[vt_sub + 1, 1, vt_sub + 1, 8].Copy(exSheet.Range[dt2.Rows.Count + temp + 6, 1, dt2.Rows.Count + temp + 6, 8], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[dt2.Rows.Count + temp + 6].RowHeight = 25;  
                exSheet.Cells[dt2.Rows.Count + temp + 6, 6].Value = Convert.ToDouble(dt1.Rows[0]["vat_amt"]);
                //toatl_amt
                exSheet.Range[vt_sub + 2, 1, vt_sub + 2, 8].Copy(exSheet.Range[dt2.Rows.Count + temp + 7, 1, dt2.Rows.Count + temp + 7, 8], XlPasteType.xlPasteAll);
                exSheet.Cells.Rows[dt2.Rows.Count + temp + 7].RowHeight = 25;
                exSheet.Cells[dt2.Rows.Count + temp + 7, 6].Value = Convert.ToDouble(dt1.Rows[0]["total_amt"]);

                total_sub += Convert.ToDouble(dt1.Rows[0]["po_amt"]);
                total_vat += Convert.ToDouble(dt1.Rows[0]["vat_amt"]);
                total_amt += Convert.ToDouble(dt1.Rows[0]["total_amt"]);
                //count now rows
                temp += 9 + dt2.Rows.Count;

            }
        }

        // total
        exSheet.Cells[temp + 1, 6].Value = total_sub;
        exSheet.Cells[temp + 2, 6].Value = total_vat;
        exSheet.Cells[temp + 3, 6].Value = total_amt;

        // loop detail not percent

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
