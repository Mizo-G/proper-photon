import { defineCollection, z } from "astro:content";

const docs = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    description: z.string(),
    dbstatus: z.string(),
    codestatus: z.string(),
    returns: z.array(z.string()),
    params: z.array(z.string()),
    refs: z.array(z.string()),
    createdby: z.string(),
  }),
});

export const collections = { docs };
