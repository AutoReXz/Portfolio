export const site = {
  name: 'Galang Rakha Ahnanta',
  title: 'Informatics Graduate',
  location: 'Yogyakarta, Indonesia',
  email: 'galangrakha1@gmail.com',
  linkedin: 'https://www.linkedin.com/in/galang-rakha',
  github: 'https://github.com/AutoReXz',
  description:
    'Informatics graduate portfolio of Galang Rakha Ahnanta, with work in AI, data, machine learning, and software integration.',
};

export const projects = [
  {
    slug: 'ta-guide-ai',
    title: 'TA-Guide AI',
    subtitle: 'WhatsApp-Integrated Retrieval-Augmented Generation Assistant',
    type: 'Independent Personal Project',
    status: 'Functional Prototype',
    summary:
      'A document-grounded assistant that retrieves relevant passages from a thesis guidance PDF and provides Indonesian answers with page references.',
    image: '/assets/projects/ta-guide-ai/n8n-workflow.png',
    alt: 'TA-Guide AI n8n WhatsApp workflow',
    tags: ['Python', 'FastAPI', 'RAG', 'ChromaDB', 'n8n'],
  },
  {
    slug: 'hoptima',
    title: 'HOPTIMA',
    subtitle: 'Machine Learning-Based Property Recommendation System',
    type: 'Bangkit Academy Capstone Project',
    status: '2024 · Team of 7',
    summary:
      'A property recommendation application for Yogyakarta that uses preferences and property attributes to surface relevant property options.',
    image: '/assets/projects/hoptima/semuanya-HOPTIMA.png',
    alt: 'HOPTIMA property recommendation application screens',
    tags: ['Python', 'TensorFlow', 'Data preprocessing', 'Recommendation systems'],
  },
];

export const skills = [
  {
    title: 'Programming & Data',
    items: ['Python', 'SQL', 'Data preprocessing', 'Data analysis'],
  },
  {
    title: 'AI & Machine Learning',
    items: ['TensorFlow', 'Machine Learning', 'Retrieval-Augmented Generation', 'Embeddings', 'Hybrid retrieval', 'LangChain'],
  },
  {
    title: 'Backend & Integration',
    items: ['FastAPI', 'REST APIs', 'Webhooks', 'n8n', 'WhatsApp Cloud API'],
  },
  {
    title: 'Tools & Infrastructure',
    items: ['Git', 'GitHub', 'Docker', 'ChromaDB', 'Streamlit', 'Caddy', 'Cloudflare Tunnel'],
  },
];

export const experience = [
  {
    period: '2024',
    organization: 'Bangkit Academy led by Google, Tokopedia, Gojek, & Traveloka',
    role: 'Machine Learning Cohort',
    detail:
      'Completed machine learning training and worked on the HOPTIMA capstone project as part of a seven-member cross-functional team.',
  },
  {
    period: 'Training',
    organization: 'Yayasan Sagasitas Indonesia',
    role: 'AI Program Participant',
    detail: 'Participated in AI-focused training and practical coursework.',
  },
  {
    period: 'Aug 2022 – Jul 2026',
    organization: 'Universitas Pembangunan Nasional "Veteran" Yogyakarta',
    role: 'Bachelor’s Degree in Informatics',
    detail: 'Undergraduate study in Informatics with interests in AI, data, software development, and system integration.',
  },
];
