//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Module
{
    using System;
    using System.Collections.Generic;
    
    public partial class Tickets
    {
        public int Id { get; set; }
        public int user_id_fk { get; set; }
        public int lottery_id_fk { get; set; }
        public int numbers { get; set; }
        public System.DateTime purchase_time { get; set; }
        public bool is_winner { get; set; }
    
        public virtual Users User { get; set; }
        public virtual Lotteries Lottery { get; set; }
    }
}
