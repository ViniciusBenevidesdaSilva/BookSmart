using DataAccess.Utils;
using Microsoft.AspNetCore.Http;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace DataAccess.DAO
{
    public static class HelperDAO
    {

        #region Métodos SQL

        public static void ExecutaSQL(string sql, SqlParameter[] parametros)
        {
            using (var conexao = ConexaoBD.GetConexao())
            {
                using (var comando = new SqlCommand(sql, conexao))
                {
                    if (parametros != null)
                        comando.Parameters.AddRange(parametros);
                    comando.ExecuteNonQuery();
                }
            }
        }

        public static DataTable ExecutaSelect(string sql, SqlParameter[] parametros)
        {
            using (var cx = ConexaoBD.GetConexao())
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(sql, cx))
                {
                    DataTable tabela = new DataTable();
                    if (parametros != null)
                        adapter.SelectCommand.Parameters.AddRange(parametros);
                    adapter.Fill(tabela);
                    return tabela;
                }
            }
        }

        public static void ExecutaProc(string nomeProc, SqlParameter[] parametros)
        {
            using (SqlConnection conexao = ConexaoBD.GetConexao())
            {
                using (SqlCommand comando = new SqlCommand(nomeProc, conexao))
                {
                    comando.CommandType = CommandType.StoredProcedure;
                    if (parametros != null)
                        comando.Parameters.AddRange(parametros);
                    comando.ExecuteNonQuery();
                }
            }
        }

        public static DataTable ExecutaProcSelect(string nomeProc, SqlParameter[] parametros)
        {
            using (SqlConnection conexao = ConexaoBD.GetConexao())
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(nomeProc, conexao))
                {
                    if (parametros != null)
                        adapter.SelectCommand.Parameters.AddRange(parametros);
                    adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                    DataTable tabela = new DataTable();
                    adapter.Fill(tabela);
                    return tabela;
                }
            }
        }

        /// <summary>
        /// Método usuado para retornar o último valor de Identity inserido em uma tabela
        /// Ou seja, após a inserção de um novo valor (Id = null), ele retorna qual valor de id foi atribuído àquele objeto
        /// </summary>
        /// <param name="tabela">Enum contendo o nome da tabela. No comando, ele atribuirá $'tb_{tabela}'</param>
        /// <returns>Retorna o último identity de uma tabela em específico</returns>
        public static int RetornaUltimaIdentity(EnumTabela tabela)
        {
            string sql =
                $"SELECT IDENT_CURRENT('{tabela}') AS Id;";

            using (SqlConnection conexao = ConexaoBD.GetConexao())
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(sql, conexao))
                {
                    DataTable retorno = new DataTable();
                    adapter.Fill(retorno);

                    conexao.Close();

                    if (retorno.Rows.Count == 0)
                        return 0;

                    var valor = retorno.Rows[0]["Id"];

                    if (valor == DBNull.Value)
                        return 0;

                    return Convert.ToInt32(valor);
                }
            }
        }

        #endregion Métodos SQL


        #region Utils

        public static object NullAsDbNull(object valor)
        {
            if (valor == null)
                return DBNull.Value;
            else
                return valor;
        }

        public static string DbNullAsString(object value)
        {
            if (value == DBNull.Value)
                return null;

            return value.ToString();
        }

        public static byte[] ConvertImageToByte(IFormFile file)
        {
            if (file != null)
            {
                using (var ms = new MemoryStream())
                {
                    file.CopyTo(ms);
                    return ms.ToArray();
                }
            }

            return null;
        }

        #endregion Utils
    }
}
