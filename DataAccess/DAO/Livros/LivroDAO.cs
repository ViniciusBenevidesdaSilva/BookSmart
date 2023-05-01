using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class LivroDAO : PadraoDAO<LivroViewModel>
    {
        protected LivroRfidDAO LivroRfidDAO { get; set; } = new LivroRfidDAO();
        protected AvaliacaoDAO AvaliacaoDAO { get; set; } = new AvaliacaoDAO();
        protected CapaLivroDAO CapaLivroDAO { get; set; } = new CapaLivroDAO();
        protected GeneroDAO GeneroDAO { get; set; } = new GeneroDAO();

        protected override SqlParameter[] CriaParametros(LivroViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter(nameof(model.Nome), model.Nome),
                new SqlParameter(nameof(model.Sinopse), model.Sinopse),
                new SqlParameter(nameof(model.Autor), model.Autor),
                new SqlParameter(nameof(model.Editora), model.Editora),
                new SqlParameter(nameof(model.Preco), model.Preco),
                new SqlParameter(nameof(model.Ano_publicacao), HelperDAO.NullAsDbNull(model.Ano_publicacao)),
                new SqlParameter("Genero_Id", model.Genero.Id)
            };

            return p;
        }

        protected override LivroViewModel MontaModel(DataRow registro)
        {
            var retorno = new LivroViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Nome = registro[nameof(retorno.Nome)].ToString();
            retorno.Sinopse = registro[nameof(retorno.Sinopse)].ToString();
            retorno.Autor = registro[nameof(retorno.Autor)].ToString();
            retorno.Editora = registro[nameof(retorno.Editora)].ToString();
            retorno.Preco = Convert.ToDouble(registro[nameof(retorno.Preco)]);
            retorno.Ano_publicacao = Convert.ToInt32(registro[nameof(retorno.Ano_publicacao)]);

            var capas = CapaLivroDAO.Listagem(ref retorno);
            retorno.Capa_Livro = capas.Count == 0 ? null : capas[0];  // Apenas o primeiro registro será a capa do livro

            retorno.Rfids = LivroRfidDAO.Listagem(ref retorno);
            retorno.Avaliacoes = AvaliacaoDAO.Listagem(ref retorno);
            retorno.Genero = GeneroDAO.Consulta(Convert.ToInt32(registro["Genero_Id"]));
            
            return retorno;
        }

        public override void Insert(LivroViewModel livro)
        {
            base.Insert(livro);

            LivroRfidDAO.Insert(livro.Rfids);
            AvaliacaoDAO.Insert(livro.Avaliacoes);
            CapaLivroDAO.Insert(livro.Capa_Livro);
        }

        public override void Update(LivroViewModel livro)
        {
            base.Update(livro);

            LivroRfidDAO.Update(livro.Rfids, livro);
            AvaliacaoDAO.Update(livro.Avaliacoes, livro);
            CapaLivroDAO.Update(livro.Capa_Livro);
        }

        public List<LivroViewModel> Listagem(int genero_id)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("Genero_Id", genero_id),
            };

            var tabela = HelperDAO.ExecutaProcSelect("spListagem_Livros", p);
            
            List<LivroViewModel> lista = new List<LivroViewModel>();

            foreach (DataRow registro in tabela.Rows)
                lista.Add(MontaModel(registro));

            return lista;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Livros;
        }
    }
}
