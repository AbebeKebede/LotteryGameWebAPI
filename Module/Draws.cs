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
    
    public partial class Draws
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Draws()
        {
            this.Winners = new HashSet<Winners>();
        }
    
        public int Id { get; set; }
        public int lottery_id_fk { get; set; }
        public System.DateTime draw_time { get; set; }
        public short winning_numbers { get; set; }
    
        public virtual Lotteries Lottery { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Winners> Winners { get; set; }
    }
}