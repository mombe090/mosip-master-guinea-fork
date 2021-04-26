variable "vphere_hosts" {
  type = list(string)
  default = [
    "mzmaster.wuriguinee.unir",
    "mzworker0.wuriguinee.unir",
    "mzworker1.wuriguinee.unir",
    "mzworker2.wuriguinee.unir",
    "mzworker3.wuriguinee.unir",
    "mzworker4.wuriguinee.unir",
    "mzworker5.wuriguinee.unir",
    "mzworker6.wuriguinee.unir",
    "mzworker7.wuriguinee.unir",
    "mzworker8.wuriguinee.unir",
    "dmzmaster.wuriguinee.unir",
    "dmzworker0.wuriguinee.unir"
  ]
}
