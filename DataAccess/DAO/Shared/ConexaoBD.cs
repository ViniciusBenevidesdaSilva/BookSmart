using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class ConexaoBD
    {
        /// <summary>
        /// Método estático que retorna uma conexão aberta com o banco CurriculoDB
        /// </summary>
        /// <returns>Retorna uma SqlConnection aberta</returns>
        public static SqlConnection GetConexao()
        {
            //string strCon = @"Data Source=LOCALHOST; Database=LivrariaDB; user id=sa; password=123456";
            string strCon = @"Data Source=LOCALHOST; Database=LivrariaDB; Integrated Security=True";
            // TODO -> EXECUTAR O SCRIPT 'MainQuery' E ALTERAR O 'Data Source' acima

            SqlConnection conexao = new SqlConnection(strCon);
            conexao.Open();

            return conexao;
        }
    }
}
