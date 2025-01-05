('eso2aikbegsh50tatl3p'u),
('eso7li7g8t6ragh0qb2f'u),
('eso8244h9m5q77qgfjb9'u),
('eso8ap0d33lq89c33afv'u),
('esoa8ve1bq71bi2l52mj'u),
('esobi785evcaa6ni4b4r'u),
('esoehsbb1he2u6dmg145'u),
('esog2vjh19tq8k28duc7'u),
('esogqrsn93n8ek0i0iat'u),
('esoj6tphlsf1mqs6e0vh'u),
('esojncnj0b78bebhmb2o'u),
('esokfm0enaons7fgm7ef'u),
('esopgseq6rvgntkftp5g'u),
('esov6nsevnt3qsfpg6do'u),



select * from (values
('eso2aikbegsh50tatl3p'u),
('eso7li7g8t6ragh0qb2f'u),
('eso8244h9m5q77qgfjb9'u),
('eso8ap0d33lq89c33afv'u),
('esoa8ve1bq71bi2l52mj'u),
('esobi785evcaa6ni4b4r'u),
('esoehsbb1he2u6dmg145'u),
('esog2vjh19tq8k28duc7'u),
('esogqrsn93n8ek0i0iat'u),
('esoj6tphlsf1mqs6e0vh'u),
('esojncnj0b78bebhmb2o'u),
('esokfm0enaons7fgm7ef'u),
('esopgseq6rvgntkftp5g'u),
('esov6nsevnt3qsfpg6do'u)
) v(id)
left only join `iam/subjects` as s on s.id = v.id


delete from `iam/access_bindings` where subject_id in (select b.subject_id from `iam/access_bindings` as b left only join `iam/subjects` as s on s.id = b.subject_id)

