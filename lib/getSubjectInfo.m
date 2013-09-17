% *************************************************************************
%
% gather test subject's information
%
% *************************************************************************
function subjectInfo = getSubjectInfo()
    prompt = {'Name:','Gender:(Male:1, Female:0)','Age:'};
    dlg_title = 'Subject information';
    num_lines = 1;
    
    subjectInfo = inputdlg(prompt,dlg_title,num_lines);