insert into public.profiles
  (id, full_name, professional_title, location, email, linkedin_url, github_url, description, is_published)
values
  ('primary', 'Galang Rakha Ahnanta', 'Informatics Graduate', 'Yogyakarta, Indonesia',
   'galangrakha1@gmail.com', 'https://www.linkedin.com/in/galang-rakha',
   'https://github.com/AutoReXz',
   'Informatics graduate portfolio of Galang Rakha Ahnanta, with work in AI, data, machine learning, and software integration.',
   true)
on conflict (id) do update set
  full_name = excluded.full_name,
  professional_title = excluded.professional_title,
  location = excluded.location,
  email = excluded.email,
  linkedin_url = excluded.linkedin_url,
  github_url = excluded.github_url,
  description = excluded.description,
  is_published = excluded.is_published;

insert into public.projects
  (slug, title, subtitle, project_type, status, summary, description, sort_order, is_published)
values
  ('ta-guide-ai', 'TA-Guide AI', 'WhatsApp-Integrated Retrieval-Augmented Generation Assistant',
   'Independent Personal Project', 'Functional Prototype',
   'A document-grounded assistant that retrieves relevant passages from a thesis guidance PDF and provides Indonesian answers with page references.',
   'An assistant for thesis guidance that combines document retrieval, a FastAPI interface, and an n8n WhatsApp workflow. The supplied source describes this as a functional prototype.',
   1, true),
  ('hoptima', 'HOPTIMA', 'Machine Learning-Based Property Recommendation System',
   'Bangkit Academy Capstone Project', '2024 · Team of 7',
   'A property recommendation application for Yogyakarta that uses preferences and property attributes to surface relevant property options.',
   'A seven-member cross-functional Bangkit Academy capstone project. The individual contribution included property data cleaning, feature preparation, exploratory analysis, recommendation-model development and evaluation, and coordination for application integration.',
   2, true)
on conflict (slug) do update set
  title = excluded.title,
  subtitle = excluded.subtitle,
  project_type = excluded.project_type,
  status = excluded.status,
  summary = excluded.summary,
  description = excluded.description,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.project_images (id, project_slug, image_url, alt_text, is_cover, sort_order)
values
  ('ta-guide-ai-workflow', 'ta-guide-ai', '/assets/projects/ta-guide-ai/n8n-workflow.png',
   'TA-Guide AI n8n WhatsApp workflow', true, 1),
  ('ta-guide-ai-whatsapp', 'ta-guide-ai', '/assets/projects/ta-guide-ai/whatsapp-demo.jpeg',
   'TA-Guide AI WhatsApp question and answer demonstration', false, 2),
  ('hoptima-screens', 'hoptima', '/assets/projects/hoptima/semuanya-HOPTIMA.png',
   'HOPTIMA property recommendation application screens', true, 1)
on conflict (id) do update set
  project_slug = excluded.project_slug,
  image_url = excluded.image_url,
  alt_text = excluded.alt_text,
  is_cover = excluded.is_cover,
  sort_order = excluded.sort_order;

insert into public.project_technologies (project_slug, technology, sort_order)
values
  ('ta-guide-ai', 'Python', 1),
  ('ta-guide-ai', 'FastAPI', 2),
  ('ta-guide-ai', 'RAG', 3),
  ('ta-guide-ai', 'ChromaDB', 4),
  ('ta-guide-ai', 'n8n', 5),
  ('hoptima', 'Python', 1),
  ('hoptima', 'TensorFlow', 2),
  ('hoptima', 'Data preprocessing', 3),
  ('hoptima', 'Recommendation systems', 4)
on conflict (project_slug, technology) do update set sort_order = excluded.sort_order;

insert into public.skills (id, category, name, sort_order, is_published)
values
  ('skill-python', 'Programming & Data', 'Python', 1, true),
  ('skill-sql', 'Programming & Data', 'SQL', 2, true),
  ('skill-data-preprocessing', 'Programming & Data', 'Data preprocessing', 3, true),
  ('skill-data-analysis', 'Programming & Data', 'Data analysis', 4, true),
  ('skill-tensorflow', 'AI & Machine Learning', 'TensorFlow', 1, true),
  ('skill-machine-learning', 'AI & Machine Learning', 'Machine Learning', 2, true),
  ('skill-rag', 'AI & Machine Learning', 'Retrieval-Augmented Generation', 3, true),
  ('skill-embeddings', 'AI & Machine Learning', 'Embeddings', 4, true),
  ('skill-hybrid-retrieval', 'AI & Machine Learning', 'Hybrid retrieval', 5, true),
  ('skill-langchain', 'AI & Machine Learning', 'LangChain', 6, true),
  ('skill-fastapi', 'Backend & Integration', 'FastAPI', 1, true),
  ('skill-rest-apis', 'Backend & Integration', 'REST APIs', 2, true),
  ('skill-webhooks', 'Backend & Integration', 'Webhooks', 3, true),
  ('skill-n8n', 'Backend & Integration', 'n8n', 4, true),
  ('skill-whatsapp-cloud-api', 'Backend & Integration', 'WhatsApp Cloud API', 5, true),
  ('skill-git', 'Tools & Infrastructure', 'Git', 1, true),
  ('skill-github', 'Tools & Infrastructure', 'GitHub', 2, true),
  ('skill-docker', 'Tools & Infrastructure', 'Docker', 3, true),
  ('skill-chromadb', 'Tools & Infrastructure', 'ChromaDB', 4, true),
  ('skill-streamlit', 'Tools & Infrastructure', 'Streamlit', 5, true),
  ('skill-caddy', 'Tools & Infrastructure', 'Caddy', 6, true),
  ('skill-cloudflare-tunnel', 'Tools & Infrastructure', 'Cloudflare Tunnel', 7, true)
on conflict (id) do update set
  category = excluded.category,
  name = excluded.name,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.experiences
  (id, period, organization, role, detail, sort_order, is_published)
values
  ('bangkit-academy', '2024', 'Bangkit Academy led by Google, Tokopedia, Gojek, & Traveloka',
   'Machine Learning Cohort',
   'Completed machine learning training and worked on the HOPTIMA capstone project as part of a seven-member cross-functional team.',
   1, true),
  ('sagasitas-training', 'Training', 'Yayasan Sagasitas Indonesia', 'AI Program Participant',
   'Participated in AI-focused training and practical coursework.', 2, true)
on conflict (id) do update set
  period = excluded.period,
  organization = excluded.organization,
  role = excluded.role,
  detail = excluded.detail,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.education
  (id, period, institution, degree, detail, sort_order, is_published)
values
  ('upn-informatics', 'Aug 2022 – Jul 2026',
   'Universitas Pembangunan Nasional "Veteran" Yogyakarta',
   'Bachelor’s Degree in Informatics',
   'Undergraduate study in Informatics with interests in AI, data, software development, and system integration.',
   3, true)
on conflict (id) do update set
  period = excluded.period,
  institution = excluded.institution,
  degree = excluded.degree,
  detail = excluded.detail,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.certifications
  (id, title, issuer, category, file_path, credential_url, is_featured, sort_order, is_published)
values
  ('cert-nlp-classification-vectors', 'Natural Language Processing with Classification and Vector Spaces', 'DeepLearning.AI', 'Artificial Intelligence & Machine Learning', '/certifications/Coursera/Coursera Natural Language Processing with Classification and Vector Spaces L6CVMDHCVAYQ.pdf', null, false, 1, true),
  ('cert-dev-tensorflow', 'Dev Certification for Machine Learning with TensorFlow', 'dev.cert by dev.id', 'Artificial Intelligence & Machine Learning', '/certifications/DCML YNVMG3PVMX.pdf', null, true, 2, true),
  ('cert-tensorflow-developer', 'DeepLearning.AI TensorFlow Developer Specialization', 'DeepLearning.AI', 'Artificial Intelligence & Machine Learning', '/certifications/Coursera/Coursera DeepLearning.AI TensorFlow Developer QLQWQX8OJ4GY.pdf', null, true, 3, true),
  ('cert-ml-specialization', 'Machine Learning Specialization', 'DeepLearning.AI', 'Artificial Intelligence & Machine Learning', '/certifications/Coursera/Coursera Machine Learning DL528VA8D2GI.pdf', null, true, 4, true),
  ('cert-generative-ai-everyone', 'Generative AI for Everyone', 'DeepLearning.AI', 'Artificial Intelligence & Machine Learning', '/certifications/Coursera/Coursera Generative AI for Everyone 3T7FMM5BCHCT.pdf', null, false, 5, true),
  ('cert-advanced-learning-algorithms', 'Advanced Learning Algorithms', 'DeepLearning.AI', 'Artificial Intelligence & Machine Learning', '/certifications/Coursera/Coursera Advanced Learning Algorithms WAVQOMA1JKY7.pdf', null, false, 6, true),
  ('cert-supervised-ml', 'Supervised Machine Learning: Regression and Classification', 'DeepLearning.AI', 'Artificial Intelligence & Machine Learning', '/certifications/Coursera/Coursera Supervised Machine Learning Regression and Classification V4AKJ4U5T3VT.pdf', null, false, 7, true),
  ('cert-unsupervised-ml', 'Unsupervised Learning, Recommenders, Reinforcement Learning', 'DeepLearning.AI', 'Artificial Intelligence & Machine Learning', '/certifications/Coursera/Coursera Unsupervised Learning, Recommenders, Reinforcement Learning Q9M7Y8ES1EBW.pdf', null, false, 8, true),
  ('cert-associate-data-scientist', 'Associate Data Scientist', 'Digital Talent Scholarship', 'Data Analytics & Data Science', '/certifications/Sertifikat_GALANG RAKHA AHNANTA_Associate Data Scientist.pdf', null, true, 9, true),
  ('cert-data-analysis-python', 'Belajar Analisis Data dengan Python', 'Dicoding Indonesia', 'Data Analytics & Data Science', '/certifications/Dicoding/Belajar Analisis Data dengan Python sertifikat_course_555_3324623_111024174137.pdf', null, true, 10, true),
  ('cert-linear-algebra-ml', 'Linear Algebra for Machine Learning and Data Science', 'DeepLearning.AI', 'Data Analytics & Data Science', '/certifications/Coursera/Coursera Linear Algebra for Machine Learning and Data Science HQ0GUPAE7W0P.pdf', null, false, 11, true),
  ('cert-data-visualization', 'Belajar Dasar Visualisasi Data', 'Dicoding Indonesia', 'Data Analytics & Data Science', '/certifications/Dicoding/Belajar Dasar Visualisasi Data sertifikat_course_177_3324623_161223230017.pdf', null, false, 12, true),
  ('cert-intro-tensorflow', 'Introduction to TensorFlow for Artificial Intelligence, Machine Learning, and Deep Learning', 'DeepLearning.AI', 'Programming & Software Development', '/certifications/Coursera/Coursera Introduction to TensorFlow for Artificial Intelligence, Machine Learning, and Deep Learning RQQWZH7DURFM.pdf', null, false, 13, true),
  ('cert-crash-course-python', 'Crash Course on Python', 'Google', 'Programming & Software Development', '/certifications/Coursera/Coursera Crash Course on Python U96YX5JOL2SV.pdf', null, false, 14, true),
  ('cert-python-operating-system', 'Using Python to Interact with the Operating System', 'Google', 'Programming & Software Development', '/certifications/Coursera/Coursera Using Python to Interact with the Operating System HG4BLFAUKRST.pdf', null, false, 15, true),
  ('cert-memulai-python', 'Memulai Pemrograman dengan Python', 'Dicoding Indonesia', 'Programming & Software Development', '/certifications/Dicoding/Memulai Pemrograman dengan Python sertifikat_course_86_3324623_111024155222.pdf', null, false, 16, true),
  ('cert-software-programming-basics', 'Memulai Dasar Pemrograman untuk Menjadi Pengembang Software', 'Dicoding Indonesia', 'Programming & Software Development', '/certifications/Dicoding/Memulai Dasar Pemrograman untuk Menjadi Pengembang Software sertifikat_course_237_3324623_111024155327.pdf', null, false, 17, true),
  ('cert-programming-logic', 'Pengenalan ke Logika Pemrograman (Programming Logic 101)', 'Dicoding Indonesia', 'Programming & Software Development', '/certifications/Dicoding/Pengenalan ke Logika Pemrograman (Programming Logic 101) sertifikat_course_302_3324623_111024155459.pdf', null, false, 18, true),
  ('cert-git-github', 'Belajar Dasar Git dengan GitHub', 'Dicoding Indonesia', 'Programming & Software Development', '/certifications/Dicoding/Belajar Dasar Git dengan GitHub sertifikat_course_317_3324623_111024155547.pdf', null, false, 19, true),
  ('cert-backend-google-cloud', 'Belajar Membuat Aplikasi Back-End untuk Pemula dengan Google Cloud', 'Dicoding Indonesia', 'Cloud & Backend Development', '/certifications/Dicoding/Belajar Membuat Aplikasi Back-End untuk Pemula dengan sertifikat_course_342_3324623_030625151033.pdf', null, false, 20, true),
  ('cert-sql', 'Belajar Dasar Structured Query Language (SQL)', 'Dicoding Indonesia', 'Cloud & Backend Development', '/certifications/Dicoding/Belajar Dasar Structured Query Language (SQL) sertifikat_course_600_3324623_111024154943.pdf', null, false, 21, true),
  ('cert-data-pipelines-tf', 'Data Pipelines with TensorFlow Data Services', 'DeepLearning.AI', 'Cloud & Backend Development', '/certifications/Coursera/Coursera Data Pipelines with TensorFlow Data Services MLKNSJP734IR.pdf', null, false, 22, true),
  ('cert-cnn-tensorflow', 'Convolutional Neural Networks in TensorFlow', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Convolutional Neural Networks in TensorFlow O1NURW5XQ7QN.pdf', null, false, 23, true),
  ('cert-sequences-timeseries', 'Sequences, Time Series and Prediction', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Sequences, Time Series and Prediction HSSY8OXP8EPX.pdf', null, false, 24, true),
  ('cert-structuring-ml-projects', 'Structuring Machine Learning Projects', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Structuring Machine Learning Projects B3BIWDVFT9X4.pdf', null, false, 25, true),
  ('cert-custom-tf-models', 'Custom Models, Layers, and Loss Functions with TensorFlow', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Custom Models, Layers, and Loss Functions with TensorFlow 0OGLAUIG1EGV.pdf', null, false, 26, true),
  ('cert-distributed-tf', 'Custom and Distributed Training with TensorFlow', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Custom and Distributed Training with TensorFlow HVN67I4CFWCF.pdf', null, false, 27, true),
  ('cert-advanced-computer-vision', 'Advanced Computer Vision with TensorFlow', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Advanced Computer Vision with TensorFlow TDTTRNBQHD5Y.pdf', null, false, 28, true),
  ('cert-browser-based-tfjs', 'Browser-based Models with TensorFlow.js', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Browser-based Models with TensorFlow.js 6H7OF8G4R90W.pdf', null, false, 29, true),
  ('cert-device-based-tflite', 'Device-based Models with TensorFlow Lite', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Device-based Models with TensorFlow Lite E8UJ76FILV1E.pdf', null, false, 30, true),
  ('cert-nlp-tensorflow', 'Natural Language Processing in TensorFlow', 'DeepLearning.AI', 'Additional Training', '/certifications/Coursera/Coursera Natural Language Processing in TensorFlow ZE5G75AO4FJ1.pdf', null, false, 31, true),
  ('cert-belajar-dasar-ai', 'Belajar Dasar AI', 'Dicoding Indonesia', 'Additional Training', '/certifications/Dicoding/Belajar Dasar AI sertifikat_course_653_3324623_111024151235.pdf', null, false, 32, true),
  ('cert-ai-advanced-elevai', 'AI Advanced: AI Track elevAIte', 'Digital Talent Scholarship', 'Artificial Intelligence & Machine Learning', null, null, true, 33, true)
on conflict (id) do update set
  title = excluded.title,
  issuer = excluded.issuer,
  category = excluded.category,
  file_path = excluded.file_path,
  credential_url = excluded.credential_url,
  is_featured = excluded.is_featured,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;
