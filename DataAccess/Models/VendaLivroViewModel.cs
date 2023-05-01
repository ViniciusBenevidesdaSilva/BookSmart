namespace DataAccess.Models
{
    public class VendaLivroViewModel : PadraoForeignViewModel<VendaViewModel>
    {
        public VendaViewModel Venda 
        { 
            get => ForeignKey;
            set => ForeignKey = value;
        }

        public LivroRFIDViewModel LivroRFID { get; set; } = new LivroRFIDViewModel();


    }
}
