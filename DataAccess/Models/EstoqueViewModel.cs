namespace DataAccess.Models
{
    public class EstoqueViewModel : PadraoViewModel
    {
        public LivroViewModel Livro { get; set; } = new LivroViewModel();
        public LivrariaViewModel Livraria { get; set; } = new LivrariaViewModel();
        public int Quantidade { get; set; }
    }
}
