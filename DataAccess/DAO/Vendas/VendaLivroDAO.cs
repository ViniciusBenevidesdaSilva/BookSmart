using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class VendaLivroDAO : PadraoForeignDAO<VendaLivroViewModel, VendaViewModel>
    {
        protected VendaDAO VendaDAO { get; set; }
        protected LivroRfidDAO LivroRfidDAO { get; set; } = new LivroRfidDAO();


        protected override SqlParameter[] CriaParametros(VendaLivroViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter("Venda_Id", model.Venda.Id),
                new SqlParameter("Livro_rfid_Id", model.LivroRFID.Id)
            };

            return p;
        }

        protected override VendaLivroViewModel MontaModel(DataRow registro)
        {
            var retorno = new VendaLivroViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Venda = VendaDAO.Consulta(Convert.ToInt32(registro["Venda_Id"]));
            retorno.LivroRFID = LivroRfidDAO.Consulta(Convert.ToInt32(registro["Livro_rfid_Id"]));

            return retorno;
        }

        protected override VendaLivroViewModel MontaModel(DataRow registro, VendaViewModel venda)
        {
            var retorno = new VendaLivroViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Venda = venda;
            retorno.LivroRFID = LivroRfidDAO.Consulta(Convert.ToInt32(registro["Livro_rfid_Id"]));

            return retorno;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Venda_Livro;
            ForeignKeyName = "Venda_Id";
        }
    }
}
