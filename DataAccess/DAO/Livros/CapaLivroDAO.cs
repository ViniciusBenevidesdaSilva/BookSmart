using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class CapaLivroDAO: PadraoForeignDAO<CapaLivroViewModel, LivroViewModel>
    {
        protected LivroDAO LivroDAO { get; set; }

        protected override SqlParameter[] CriaParametros(CapaLivroViewModel model)
        {
            object imgByte = DBNull.Value;

            if (model != null && model.ImagemEmByte != null)
                imgByte = model.ImagemEmByte;


            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter("Livro_Id", model.Livro.Id),
                new SqlParameter("Capa_Livro", imgByte)
            };

            return p;
        }

        protected override CapaLivroViewModel MontaModel(DataRow registro)
        {
            LivroDAO = new LivroDAO();

            var retorno = new CapaLivroViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Livro = LivroDAO.Consulta(Convert.ToInt32(registro["Livro_Id"]));

            if (registro["Capa_Livro"] != DBNull.Value)
                retorno.ImagemEmByte = registro["Capa_Livro"] as byte[];

            return retorno;
        }

        protected override CapaLivroViewModel MontaModel(DataRow registro, LivroViewModel livro)
        {
            var retorno = new CapaLivroViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Livro = livro;

            if (registro["Capa_Livro"] != DBNull.Value)
                retorno.ImagemEmByte = registro["Capa_Livro"] as byte[];

            return retorno;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Capa_Livro;
            ForeignKeyName = "Livro_Id";
        }
    }
}
