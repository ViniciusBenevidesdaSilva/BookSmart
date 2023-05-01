using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class AvaliacaoDAO : PadraoForeignDAO<AvaliacaoViewModel, LivroViewModel>
    {
        //TODO: Alterar nome da tabela Avaliacoes
        //TODO: Comentar métodos
        protected ClienteDAO ClienteDAO { get; set; } = new ClienteDAO();
        protected LivroDAO LivroDAO { get; set; }

        protected override SqlParameter[] CriaParametros(AvaliacaoViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter("Cliente_Id", model.Cliente.Id),
                new SqlParameter("Livro_Id", model.Livro.Id),
                new SqlParameter(nameof(model.Nota), model.Nota),
                new SqlParameter(nameof(model.Resenha), HelperDAO.NullAsDbNull(model.Resenha)),
                new SqlParameter(nameof(model.Data_Avaliacao), model.Data_Avaliacao),
            };

            return p;
        }
       
        protected override AvaliacaoViewModel MontaModel(DataRow registro)
        {
            LivroDAO = new LivroDAO();

            var retorno = new AvaliacaoViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Cliente = ClienteDAO.Consulta(Convert.ToInt32(registro["Cliente_Id"]));
            retorno.Livro = LivroDAO.Consulta(Convert.ToInt32(registro["Livro_Id"]));
            retorno.Data_Avaliacao = Convert.ToDateTime(registro[nameof(retorno.Data_Avaliacao)]);
            retorno.Nota = Convert.ToInt32(registro[nameof(retorno.Nota)]);
            retorno.Resenha = HelperDAO.DbNullAsString(registro[nameof(retorno.Resenha)]);

            return retorno;
        }
        
        protected override AvaliacaoViewModel MontaModel(DataRow registro, LivroViewModel livro)
        {
            var retorno = new AvaliacaoViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Cliente = ClienteDAO.Consulta(Convert.ToInt32(registro["Cliente_Id"]));
            retorno.Livro = livro;
            retorno.Data_Avaliacao = Convert.ToDateTime(registro[nameof(retorno.Data_Avaliacao)]);
            retorno.Nota = Convert.ToInt32(registro[nameof(retorno.Nota)]);
            retorno.Resenha = HelperDAO.DbNullAsString(registro[nameof(retorno.Resenha)]);

            return retorno;
        }
        
        protected override void SetTabela()
        {
            Tabela = EnumTabela.Avaliacoes;
            ForeignKeyName = "Livro_Id";
        }
    }
}
