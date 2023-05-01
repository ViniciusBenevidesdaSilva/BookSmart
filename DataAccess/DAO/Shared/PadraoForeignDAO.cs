using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace DataAccess.DAO
{
    /// <summary>
    /// O Objetivo dessa clase é ser herdada por objetos que possam ser chave estrageira, tendo a opção de salvar uma lista <T>
    /// </summary>
    /// <typeparam name="T">T é a ViewModel original</typeparam>
    /// <typeparam name="U">U é a ViewModel do pai (foreign Key)</typeparam>
    public abstract class PadraoForeignDAO<T, U> : PadraoDAO<T> where T : PadraoForeignViewModel<U> where U : PadraoViewModel
    {
        protected string ForeignKeyName { get; set; }

        protected abstract T MontaModel(DataRow registro, U foreignKey);


        public virtual void Insert(List<T> models)
        {
            foreach (var model in models)
                Insert(model);            
        }

        /// <summary>
        /// O método update será diferenciado, uma vez que ele precisa validar quais objetos da lista precisam ser inseridos, atualizados ou excluidos
        /// </summary>
        /// <param name="models"></param>
        public virtual void Update(List<T> models, U foreign)
        {
            List<int?> excluidos = Listagem(ref foreign).Where(x => !models.Select(f => f.ForeignKey.Id).Contains(x.Id)).Select(x => x.Id).ToList();

            foreach (var excluido in excluidos)
                Delete(excluido);

            foreach (var model in models)
                Update(model);
        }
        
        public virtual List<T> Listagem(ref U foreignKey)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("tabela", Tabela.ToString()),
                new SqlParameter("ForeignKeyName", ForeignKeyName),
                new SqlParameter("Foreign_Id", foreignKey.Id)
           };

            var tabela = HelperDAO.ExecutaProcSelect("spListagem_Foreign", p);

            List<T> lista = new List<T>();

            foreach (DataRow registro in tabela.Rows)
                lista.Add(MontaModel(registro, foreignKey));

            return lista;
        }
    }
}
