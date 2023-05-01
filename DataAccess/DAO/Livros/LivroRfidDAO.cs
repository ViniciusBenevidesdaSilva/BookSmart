using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class LivroRfidDAO : PadraoForeignDAO<LivroRFIDViewModel, LivroViewModel>
    {
        protected LivroDAO LivroDAO { get; set; }
        protected LivrariaDAO LivrariaDAO { get; set; } = new LivrariaDAO();

        protected override SqlParameter[] CriaParametros(LivroRFIDViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter(nameof(model.Rfid), model.Rfid),
                new SqlParameter("Livro_Id", model.Livro.Id),
                new SqlParameter("Livraria_Id", model.Livraria.Id),
                new SqlParameter(nameof(model.Flag_disponivel), Convert.ToByte(model.Flag_disponivel))
            };

            return p;
        }

        protected override LivroRFIDViewModel MontaModel(DataRow registro)
        {
            LivroDAO = new LivroDAO();

            var retorno = new LivroRFIDViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Rfid = registro[nameof(retorno.Rfid)].ToString();
            retorno.Livro = LivroDAO.Consulta(Convert.ToInt32(registro["Livro_Id"]));
            retorno.Livraria = LivrariaDAO.Consulta(Convert.ToInt32(registro["Livraria_Id"]));
            retorno.Flag_disponivel = (EnumFlagDisponibilidade)Convert.ToByte(registro[nameof(retorno.Flag_disponivel)]);

            return retorno;
        }

        protected override LivroRFIDViewModel MontaModel(DataRow registro, LivroViewModel livro)
        {
            var retorno = new LivroRFIDViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Rfid = registro[nameof(retorno.Rfid)].ToString();
            retorno.Livro = livro;
            retorno.Livraria = LivrariaDAO.Consulta(Convert.ToInt32(registro["Livraria_Id"]));
            retorno.Flag_disponivel = (EnumFlagDisponibilidade)Convert.ToByte(registro[nameof(retorno.Flag_disponivel)]);

            return retorno;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Livro_Rfid;
            ForeignKeyName = "Livro_Id";
        }
    }
}
